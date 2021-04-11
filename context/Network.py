import logging
import random
import time
from math import ceil

from scipy import stats

from context.NetworkRound import NetworkRound, calculate_prev_round_f_av
from context.Peer import Peer
from ledger.Transaction import Transaction


def get_peer_costs(total_peers):
    lower, upper = 0.5, 1.5
    mu, sigma = 1, 0.25
    X = stats.truncnorm(
        (lower - mu) / sigma, (upper - mu) / sigma, loc=mu, scale=sigma)
    return X.rvs(total_peers)


class Network:
    def __init__(self, run_id, run_name, total_peers, required_votes, timeout_in_seconds, learning_strategy,
                 is_cost_heterogeneous, benefit_per_unit_of_cost, minimum_attack_probability, desc_data):
        # Static Constants
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
        self.count_of_votes_required = ceil(total_peers * float(votes_required))
        self.m = self.total_peers - self.count_of_votes_required  # byzantine players tolerable
        self.tolerance = 1 - votes_required  # m/n
        # End of Static Constants

        # Setting environment constants
        self.run = run_id
        self.run_name = run_name
        self.block_timeout = timeout_in_seconds
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
        peer = Peer(node_id, self.total_peers, self.count_of_votes_required, self.benefit_per_unit_of_cost, self.peer_costs.pop(), self.learning_strategy, self.tolerance)
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

    def get_proposer(self):  # For genesis block
        proposer = random.choice(list(self.peers.keys()))
        logging.debug("Network.get_proposer: %s", proposer)
        return proposer

    def set_curr_block_timeout(self):
        logging.debug("Network.set_curr_block_timeout")
        self.curr_block_timeout = time.time() + self.block_timeout

    def is_block_timed_out(self):
        return time.time() > self.curr_block_timeout
