import json
import logging
import random
import uuid
from collections import defaultdict

from context.Constants import const_none
from ledger.Block import Block


class Peer:
    def __init__(self, who_id, count_of_votes_required):
        self.who_id = who_id  # Constant NetLogo Id For Reference only
        self.__votes_required = count_of_votes_required
        self.peer_id = str(uuid.uuid4())
        self.transactions = defaultdict(list)  # TODO
        self.blockchain = list()
        self.is_under_attack = False
        self.is_protected = False
        self.proposers = list()
        self.__peer_set = set()
        self.picked_proposer_set = set()
        self.current_block = None
        self.current_block_accepted = True
        self.previous_block_signature = "-1"  # TODO Note genesis block
        self.state = None  # TODO
        self.strategy = None  # TODO
        self.proposed_accepted_list = list()  # Only used when self is the proposer. Simulation termination purposes
        self.proposer_accepted = False

    def log_chain(self):
        logging.debug("Peer.print_chain: Begin %s, %s", self.who_id, self.peer_id)
        for block_item in self.blockchain:
            block_item.log_block_string()
        logging.debug("Peer.print_chain: End %s, %s", self.who_id, self.peer_id)

    def start_round(self):
        self.is_under_attack = False
        self.is_protected = False
        self.set_protected()
        self.proposers.clear()

    def set_transactions(self, transactions_json):
        if self.is_under_attack:
            return
        json_dict = json.loads(transactions_json)
        self.transactions.update(json_dict)

    def get_transactions_json(self):
        return str(json.dumps(self.transactions))

    def get_id(self):
        return self.peer_id

    def purge_committed_transactions(self):
        # TODO Why transactions are empty?
        for transaction_key in self.current_block.get_transaction_keys():
            if transaction_key in self.transactions.keys():
                self.transactions.pop(transaction_key)

    def set_under_attack(self):
        self.is_under_attack = not self.is_protected
        if self.is_under_attack:
            logging.debug("Peer.set_under_attack: %s", self.who_id)
        return self.is_under_attack

    def unset_under_attack(self):
        self.is_under_attack = False

    def set_protected(self):
        self.is_protected = bool(self.who_id % 3 != 1)  # TODO pick value based on strategy and previous blocks

    def set_peer_set(self, peer_set):
        self.__peer_set = peer_set

    def get_proposer(self):
        selected_proposer = None
        leftover_proposers = self.__peer_set - set(self.proposers) - self.picked_proposer_set
        if len(leftover_proposers) > 0:
            selected_proposer = random.choice(list(leftover_proposers))
        elif len(self.proposers) > 0:
            for candidate in self.proposers:
                if candidate not in self.picked_proposer_set:
                    selected_proposer = candidate
                    break
        if selected_proposer is None:  # Ambiguous situation for when lists are empty
            leftover_proposers = self.__peer_set - self.picked_proposer_set
            if len(leftover_proposers) > 0:
                selected_proposer = random.choice(list(leftover_proposers))
            else:
                selected_proposer = random.choice(list(self.__peer_set))
        self.picked_proposer_set.add(selected_proposer)
        logging.debug("Peer.get_proposer: %s", selected_proposer)
        return selected_proposer

    def proposer_transfer_complete(self):
        self.picked_proposer_set.clear()

    def accept_proposer_position(self):
        self.proposed_accepted_list.clear()
        self.picked_proposer_set.add(self.peer_id)

    def propose_block(self, ticks):
        if len(self.transactions) == 0:
            return const_none
        # TODO add transactions some other way with regard to their timing order
        new_block_index = len(self.blockchain)
        block = Block(new_block_index, self.transactions, ticks,
                      self.previous_block_signature, self.peer_id)
        logging.debug("Peer.propose_block: %s", block.get_json())
        return block.get_json()

    def accept_block(self):
        # logging.debug("Peer.accept_block")
        if self.current_block.vote_count() < self.__votes_required:
            return False
        logging.debug("Peer.accept_block : Enough votes received. Accepting Block. Votes: %d/%d, By: %s",
                      self.current_block.vote_count(), self.__votes_required, self.who_id)
        self.blockchain.append(self.current_block)
        self.previous_block_signature = self.current_block.block_signature()
        self.purge_committed_transactions()
        self.current_block_accepted = True
        return True

    def update_current_block(self, block_json):
        verified_votes = False
        if self.current_block_accepted:
            eval_block = Block.from_json(block_json)
            verified, index = eval_block.verify(self.previous_block_signature, self.transactions)
            if verified:
                self.current_block = eval_block
                self.current_block_accepted = False
            if len(self.blockchain) < index:
                logging.info("Peer.update_current_block: Needs to obtain blockchain")
                return False, [len(self.blockchain), index - 1]  # TODO request blockchain from neighbors
        if not self.current_block_accepted:
            verified_votes = self.current_block.update_votes(block_json, self.__peer_set)
        if verified_votes:
            self.current_block.vote(self.peer_id)
            self.accept_block()  # TODO voting in order for reputation collection, UniqueList?
        return True, 0

    def get_current_block_json(self):
        json_output = ""
        if self.current_block is not None:
            json_output = self.current_block.get_json()
        if self.current_block_accepted:
            # logging.debug("Peer.get_current_block_json: Block Added Successfully")
            pass
        return [self.current_block_accepted, json_output]

    def get_blockchain_slice(self, index_from, index_to):
        logging.debug("Peer.get_blockchain_slice: Sending blocks from %d to %d from %s", index_from, index_to,
                      self.peer_id)
        if self.blockchain[index_from].index == index_from and self.blockchain[index_to].index == index_to:
            logging.debug("Peer.get_blockchain_slice: Slice Accurate")
        else:
            logging.debug("Peer.get_blockchain_slice: Slice Inaccurate")
        return self.blockchain[index_from: index_to]

    def set_blockchain_slice(self, index_from, blockchain_slice):
        self.blockchain.extend(blockchain_slice)
        logging.debug(blockchain_slice)
        try:
            index_to = self.blockchain[len(self.blockchain) - 1].index
        except IndexError:
            logging.debug("Exception: Index out of range err. Blockchain Index: %d", len(self.blockchain) - 1)
            index_to = 0
        logging.debug("Peer.set_blockchain_slice: Added blocks from %d to %d from %s", index_from,
                      index_to, self.peer_id)
        return len(self.blockchain) - 1

    def collect_added_vote(self, added_by_peer):
        self.proposed_accepted_list.append(added_by_peer)

    def check_proposed_block_status(self):
        if not self.proposer_accepted:
            self.proposer_accepted = len(self.proposed_accepted_list) >= self.__votes_required
            logging.debug("Peer.check_proposed_block_status: %s", self.proposer_accepted)
        return self.proposer_accepted
