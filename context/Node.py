import json
import logging
from collections import defaultdict
from copy import copy

from context.Constants import const_empty_json
from ledger.Block import Block


class Node:
    def __init__(self):
        self.votes_required = None
        self.transactions = defaultdict(list)
        self.blockchain = list()
        self.previous_block_signature = "-1"  # TODO Note genesis block
        self.block_in_voting = None

    def set_votes_required(self, value):
        self.votes_required = value

    def update_transactions(self, transactions_json):
        json_dict = json.loads(transactions_json)
        self.transactions.update(json_dict)

    def set_transactions(self, transactions_json):
        self.update_transactions(transactions_json)

    def purge_committed_transactions(self, accepted_block):
        for transaction_key in list(accepted_block.get_transaction_keys()):
            if transaction_key in list(self.transactions.keys()):
                self.transactions.pop(transaction_key)

    def get_new_block(self, ticks):
        self.block_in_voting = None
        if len(self.transactions) == 0:
            logging.debug("Node.get_new_block: No transactions")
            return const_empty_json
        new_block_index = len(self.blockchain)
        block_transactions = copy(self.transactions)
        self.block_in_voting = Block(new_block_index, block_transactions, ticks, self.previous_block_signature)
        logging.debug("Node.get_new_block: %s", self.block_in_voting.get_json())
        return self.block_in_voting.get_json()

    def append_to_chain(self):
        self.previous_block_signature = self.block_in_voting.get_full_signature()
        self.blockchain.append(self.block_in_voting)
        self.purge_committed_transactions(self.block_in_voting)

    def get_current_block(self):
        return self.block_in_voting.get_json()

    def get_current_vote_count(self):
        if self.block_in_voting is None:
            return 0
        return self.block_in_voting.vote_count()

    def vote_for_block(self, voting_peer):
        self.block_in_voting.vote(voting_peer)

    def check_proposed_block_status(self):
        block_accepted = self.block_in_voting.vote_count() >= self.votes_required
        if block_accepted:
            self.append_to_chain()
        logging.debug("Node.check_proposed_block_status: Accepted : %d, Block: %s", block_accepted,
                      self.block_in_voting.get_json())
        return block_accepted

    def updated_blockchain_data(self, blockchain_length, prev_block_signature, txn_key_list):
        logging.debug("Node.updated_blockchain_data")
        expired_txn, missing_txn_list_json = self.__missing_transactions(txn_key_list)
        missing_block_list = self.__missing_blocks(blockchain_length, prev_block_signature)
        expired_chain = len(missing_block_list) > 0
        missing_block_list_json = json.dumps(missing_block_list)
        return expired_txn and expired_chain, missing_block_list_json, missing_txn_list_json

    def __missing_transactions(self, txn_key_list):
        missing_txn_list = copy(self.transactions)
        txn_keys = list(json.loads(txn_key_list))
        for transaction_key in txn_keys:
            if transaction_key in list(missing_txn_list.keys()):
                missing_txn_list.pop(transaction_key)
        expired = len(missing_txn_list) > 0
        return expired, json.dumps(missing_txn_list)

    def __missing_blocks(self, peer_chain_length, prev_block_signature):
        block_count = len(self.blockchain)
        missing_block_list = []
        if block_count == 0:
            # logging.debug("Node.missing_blocks: Nothing to update. Empty Blockchain")
            return missing_block_list
        if block_count == peer_chain_length and self.previous_block_signature == prev_block_signature:
            # logging.debug("Node.missing_blocks: Nothing to update. Blockchain up to date")
            return missing_block_list
        if block_count < peer_chain_length:
            logging.debug("Node.missing_blocks: ERROR. Peer blockchain length longer than parent")
            return missing_block_list
        if peer_chain_length < 1:
            logging.debug("Node.missing_blocks: ERROR. Invalid Blockchain Length")
            return missing_block_list
        if self.blockchain[peer_chain_length - 1].get_full_signature() != prev_block_signature:
            logging.debug("Node.missing_blocks: ERROR. Peer blockchain is forked")
            return missing_block_list
        missing_block_list = self.blockchain[peer_chain_length - 1:]
        return missing_block_list
