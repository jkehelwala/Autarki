import random
from math import floor


def calculate_prev_round_f_av(peers):
    total_peers = len(peers)
    f_list = list()
    for peer_id, peer in peers.items():
        f = peer.chosen_strategy.get_prev_round_f()
        f_list.append(f)
    f_av = sum(f_list) / total_peers
    return f_av


class NetworkRound:
    def __init__(self, r_id, total_peers, attack_probability, prev_f):
        self.r_id = r_id
        self.total_peers = total_peers
        self.attack_probability = attack_probability  # mu
        # self.prev_f = prev_f  # Total percentage of accepted blocks
        no_of_blocks_to_attack = floor(self.attack_probability * self.total_peers)  # TODO ceil or floor?
        self.attacked_rounds = random.sample(range(1, self.total_peers + 1), no_of_blocks_to_attack)
        # self.blocks = list()

    def get_attacking_rounds(self):
        return self.attacked_rounds
