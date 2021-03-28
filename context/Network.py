import logging
import random
import time
from math import ceil

from context.NetworkRound import NetworkRound
from context.Peer import Peer
from ledger.Transaction import Transaction


class Network:
    def __init__(self, run_id, run_name, total_peers, required_votes, timeout_in_seconds, learning_strategy,
                 is_cost_heterogeneous, benefit_per_unit_of_cost, minimum_attack_probability, desc_data):
        # Setting environment constants
        self.run = run_id
        self.run_name = run_name
        self.total_peers = total_peers
        self.block_timeout = timeout_in_seconds
        self.learning_strategy = learning_strategy
        self.is_cost_heterogeneous = is_cost_heterogeneous
        self.benefit_per_unit_of_cost = benefit_per_unit_of_cost
        self.minimum_attack_probability = minimum_attack_probability
        votes_required = (float(required_votes) / 100.00)
        self.count_of_votes_required = ceil(total_peers * float(votes_required))
        # End of setting environment constants
        self.transactions = dict()
        self.peers = dict()
        self.rounds = dict()
        self.curr_block_timeout = None
        self.experiment_descriptive_data = desc_data

    def no_of_attackers_tolerable(self):
        return self.total_peers - self.count_of_votes_required

    def log_network_chain(self):
        for id_key, peer in self.peers.items():
            peer.log_chain()

    def create_peer(self, node_id):
        peer = Peer(node_id, self.count_of_votes_required)
        self.peers[peer.get_id()] = peer
        return peer.get_id()

    def create_transaction(self, time):
        n_transaction = Transaction(time)
        self.transactions[int(time)] = n_transaction
        return n_transaction.get_transaction_json()

    def get_peer(self, peer_id):
        return self.peers[peer_id]

    def start_round(self, round_number):
        attack_probability = random.uniform(self.minimum_attack_probability, 1)
        self.rounds[round_number] = NetworkRound(round_number, self.total_peers, attack_probability)
        for peer_id, peer_item in self.peers.items():
            peer_item.start_round()

    def get_round(self, curr_round):
        return self.rounds[curr_round]

    def set_peer_network_variables(self, peer_set):
        for peer_id, peer_item in self.peers.items():
            peer_item.set_peer_set(peer_set)

    def get_proposer(self):  # For genesis block
        proposer = random.choice(list(self.peers.keys()))
        logging.debug("Network.get_proposer: %s", proposer)
        return proposer

    def set_curr_block_timeout(self):
        logging.debug("Network.set_curr_block_timeout")
        self.curr_block_timeout = time.time() + self.block_timeout

    def is_block_timed_out(self):
        return time.time() > self.curr_block_timeout
