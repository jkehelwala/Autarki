import json
import logging
import random
import time
from collections import defaultdict
from math import ceil

from scipy import stats

from context.NetworkRound import NetworkRound, calculate_prev_round_f_av
from context.Peer import Peer
from context.Node import Node
from ledger.Transaction import Transaction


def get_peer_costs(total_peers):
    lower, upper = 0.5, 1.5
    mu, sigma = 1, 0.25
    X = stats.truncnorm(
        (lower - mu) / sigma, (upper - mu) / sigma, loc=mu, scale=sigma)
    return X.rvs(total_peers)


class Network(Node):
    def __init__(self, run_id, run_name, total_peers, required_votes, learning_strategy, is_cost_heterogeneous,
                 benefit_per_unit_of_cost, minimum_attack_probability, desc_data):
        # Static Constants
        super().__init__()
        self.total_peers = total_peers  # total_peers
        self.learning_strategy = learning_strategy
        self.is_cost_heterogeneous = is_cost_heterogeneous
        if self.is_cost_heterogeneous:
            self.peer_costs = get_peer_costs(self.total_peers)
        else:
            self.peer_costs = [1] * self.total_peers
        self.benefit_per_unit_of_cost = benefit_per_unit_of_cost
        self.minimum_attack_probability = minimum_attack_probability
        votes_required = (float(required_votes) / 100.00)
        self.set_votes_required(ceil(total_peers * float(votes_required)))
        self.m = self.total_peers - self.votes_required  # byzantine players tolerable
        self.tolerance = 1 - votes_required  # m/n
        # End of Static Constants

        # Setting environment constants
        self.run = run_id
        self.run_name = run_name
        # End of setting environment constants
        self.blockchain = list()
        self.peers = dict()
        self.rounds = dict()
        self.experiment_descriptive_data = desc_data

    def no_of_attackers_tolerable(self):
        return self.total_peers - self.votes_required

    def log_network_chain(self):
        for id_key, peer in self.peers.items():
            peer.log_chain()

    def create_peer(self, node_id):
        peer = Peer(node_id, self.total_peers, self.votes_required, self.benefit_per_unit_of_cost,
                    self.peer_costs.pop(), self.learning_strategy, self.tolerance)
        self.peers[peer.get_id()] = peer
        return peer.get_id()

    def create_transaction(self, time):
        n_transaction = Transaction(time)
        json_value = n_transaction.get_transaction_json()
        self.set_transactions(json_value)
        return json_value

    def get_peer(self, peer_id):
        return self.peers[peer_id]

    def start_round(self, round_number):
        attack_probability = random.uniform(self.minimum_attack_probability, 1)
        # prev_f = 0
        # if round_number > 1:
        #     prev_f = calculate_prev_round_f_av(self.peers)
        self.rounds[round_number] = NetworkRound(round_number, self.total_peers, attack_probability, 0)
        for peer_id, peer_item in self.peers.items():
            peer_item.start_round(round_number)

    def get_round(self, curr_round):
        return self.rounds[curr_round]

    def set_peer_network_variables(self, peer_set):
        for peer_id, peer_item in self.peers.items():
            peer_item.set_peer_set(peer_set)

