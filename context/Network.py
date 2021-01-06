import logging
import random
from math import ceil

from context.NetworkRound import NetworkRound
from context.Peer import Peer
from ledger.Transaction import Transaction


class Network:
    def __init__(self, run_id):
        self.run = run_id
        self.transactions = dict()
        self.peers = dict()
        self.rounds = dict()

    def log_network_chain(self):
        for id_key, peer in self.peers.items():
            peer.log_chain()

    def create_peer(self, node_id):
        peer = Peer(node_id)
        self.peers[peer.get_id()] = peer
        return peer.get_id()

    def create_transaction(self, time):
        n_transaction = Transaction(time)
        self.transactions[int(time)] = n_transaction
        return n_transaction.get_transaction_json()

    def get_peer(self, peer_id):
        return self.peers[peer_id]

    def start_round(self, round_number, no_blocks_per_round, attack_probability_range):
        self.rounds[round_number] = NetworkRound(round_number, no_blocks_per_round, attack_probability_range)
        for peer_id, peer_item in self.peers.items():
            peer_item.start_round()

    def get_round(self, curr_round):
        return self.rounds[curr_round]

    def set_peer_network_variables(self, peer_set, votes_required):
        count_votes_required = ceil(len(self.peers) * float(votes_required))
        for peer_id, peer_item in self.peers.items():
            peer_item.set_network_variables(peer_set, votes_required, count_votes_required)

    def get_proposer(self):  # For genesis block
        proposer = random.choice(list(self.peers.keys()))
        logging.debug("Network.get_proposer: %s", proposer)
        return proposer
