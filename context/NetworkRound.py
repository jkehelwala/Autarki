import random
from collections import OrderedDict
from math import floor


class NetworkRound:
    def __init__(self, r_id, no_blocks_per_round, attack_probability):
        self.r_id = r_id
        self.blocks = list()
        self.attack_probability = attack_probability
        no_of_blocks_to_attack = floor(self.attack_probability * no_blocks_per_round)  # TODO ceil or floor?
        self.attacked_rounds = random.sample(range(1, no_blocks_per_round + 1), no_of_blocks_to_attack)

    def get_attacking_rounds(self):
        return self.attacked_rounds
