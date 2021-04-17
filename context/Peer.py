import json
import logging
import uuid

from context.Node import Node
from learning import LearningMethodologyFactory
from ledger.Block import Block


class Peer(Node):
    def __init__(self, who_id, total_peers, count_of_votes_required, benefit_per_unit_of_cost, cost, learning_strategy,
                 tolerance):
        super().__init__()
        self.who_id = who_id  # Constant NetLogo Id For Reference only
        self.set_votes_required(count_of_votes_required)  # Super class mandatory call
        self.node_id = str(uuid.uuid4())
        self.is_under_attack = False
        self.is_protected = False
        self.__peer_set = set()
        self.current_block = Block(-1, {}, "", "")
        self.current_block_accepted = True
        self.learning_choice = learning_strategy
        self.chosen_strategy = None
        self.proposed_accepted_list = list()  # Only used when self is the proposer. Simulation termination purposes
        self.prev_round_chain_length = 0
        # For calculations
        self.total_peers = total_peers
        self.__cost = cost
        self.benefit = benefit_per_unit_of_cost * self.__cost
        self.tolerance = tolerance

    def log_chain(self):
        logging.debug("Peer.print_chain: Begin %s, %s", self.who_id, self.node_id)
        for block_item in self.blockchain:
            block_item.log_block_string()
        logging.debug("Peer.print_chain: End %s, %s", self.who_id, self.node_id)

    def start_round(self, round_no):
        self.is_under_attack = False
        self.is_protected = False
        self.chosen_strategy = None
        self.set_protected()
        self.prev_round_chain_length = len(self.blockchain)
        logging.debug("Peer.start_round: Protected: %s", self.is_protected)

    def set_transactions(self, transactions_json):
        if self.is_under_attack:
            return
        self.update_transactions(transactions_json)

    def get_transactions_json(self):
        return str(json.dumps(self.transactions))

    def get_id(self):
        return self.node_id

    def set_under_attack(self):
        self.is_under_attack = not self.is_protected
        if self.is_under_attack:
            logging.debug("Peer.set_under_attack: %s", self.who_id)
        return self.is_under_attack

    def unset_under_attack(self):
        self.is_under_attack = False

    def set_protected(self):
        self.chosen_strategy = LearningMethodologyFactory.get_learning_methodology(self.learning_choice, self)
        self.is_protected = self.chosen_strategy.is_investing_in_security()

    def get_blocks_in_round(self):
        if self.prev_round_chain_length <= 0:
            return None
        return self.blockchain[self.prev_round_chain_length:]

    def set_peer_set(self, peer_set):
        self.__peer_set = peer_set

    def accept_block_to_chain(self, block_json):
        logging.debug("Peer.accept_block_to_chain")
        self.block_in_voting = Block.from_json(block_json)
        self.block_in_voting.set_voter_signature()
        voter_verify = self.block_in_voting.verify_voters(self.__peer_set)
        verified = voter_verify and self.block_in_voting.verify(self.previous_block_signature, self.transactions)
        if not verified:
            return False
        logging.debug("Peer.accept_block_to_chain : Accepting Block. Votes: %d/%d, By: %s",
                      self.block_in_voting.vote_count(), self.votes_required, self.who_id)
        self.append_to_chain()
        return True

    def authenticate_and_vote(self, block_json):
        eval_block = Block.from_json(block_json)
        verified = eval_block.verify(self.previous_block_signature, self.transactions)
        logging.debug("Peer.authenticate_and_vote : Vote %d", verified)
        return verified

    def get_poll_request_data(self):
        logging.debug("Peer.get_poll_request_data")
        txn_key_list = str(json.dumps(list(self.transactions.keys())))
        return len(self.blockchain), self.previous_block_signature, txn_key_list

    def update_blockchain(self, blockchain_json, transactions_json):
        logging.debug("Peer.update_blockchain. Txn: %s", transactions_json)
        logging.debug("Peer.update_blockchain. Chain: %s", blockchain_json)
        self.set_transactions(transactions_json)
        json_array = json.loads(blockchain_json)
        if len(json_array) < 1:
            return
        for json_block in json_array:
            logging.debug("Peer.update_blockchain %s", json_block)
            self.accept_block_to_chain(json_block)
