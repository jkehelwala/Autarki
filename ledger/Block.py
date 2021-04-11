import hashlib
import hmac
import json
import logging

from context.Constants import BlockConst


class Block:
    def __init__(self, index, transactions, timestamp, previous_hash, proposer_id):
        self.index = index
        self.transactions = transactions
        self.timestamp = timestamp
        self.previous_hash = previous_hash
        self.proposer = proposer_id
        self.votes = set()
        self.votes.add(self.proposer)
        self.signature = self.get_signature(self.proposer)

    def get_index(self):
        return self.index

    def get_signature(self, proposer):
        signature = str(self.index) + str(self.transactions) + str(self.timestamp) + str(self.previous_hash)
        h = hmac.new(str.encode(proposer), str.encode(signature), hashlib.sha256)
        return str(h.hexdigest())

    def block_signature(self):
        return self.signature

    def get_transaction_keys(self):
        return self.transactions.keys()

    def log_block_string(self):
        json_dict = {
            BlockConst.index: self.index,
            BlockConst.timestamp: self.timestamp,
            BlockConst.proposer: self.proposer,
            BlockConst.previous_hash: self.previous_hash,
            BlockConst.signature: self.signature,
            # BlockConst.votes: ",".join(list(self.votes))
        }
        logging.debug(json.dumps(json_dict))  # TODO  BlockConst.transactions

    def get_json(self):
        json_dict = {
            BlockConst.index: self.index,
            BlockConst.transactions: self.transactions,  # TODO How will these be converted?
            BlockConst.timestamp: self.timestamp,
            BlockConst.proposer: self.proposer,
            BlockConst.previous_hash: self.previous_hash,
            BlockConst.signature: self.signature,
            BlockConst.votes: list(self.votes)
        }
        return json.dumps(json_dict)

    def update_votes(self, json_string, peers):
        block = json.loads(json_string)
        if self.signature != block[BlockConst.signature]:
            return
        self.set_votes(block[BlockConst.votes])
        return self.votes.issubset(peers)

    def vote_count(self):
        return len(self.votes)

    def vote(self, voter):
        self.votes.add(voter)

    def set_votes(self, vote_list):
        self.votes.update(set(vote_list))

    @classmethod
    def from_json(cls, json_string):
        block = json.loads(json_string)  # TODO Note JSONDecodeError could occur
        new_block = cls(block[BlockConst.index], block[BlockConst.transactions], block[BlockConst.timestamp],
                        block[BlockConst.previous_hash], block[BlockConst.proposer])
        new_block.set_votes(block[BlockConst.votes])
        return new_block

    def verify(self, prev_hash, voter_transactions):
        verified = self.previous_hash == prev_hash
        if verified:
            verified = self.transactions.items() <= voter_transactions.items()  # Check if subset
        return verified

    def has_voted(self, peer_id):
        return peer_id in self.votes

    def get_votes(self):
        return self.votes
