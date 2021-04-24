import random

from learning.PeerLearningMethodology import PeerLearningMethodology


class Random(PeerLearningMethodology):
    def __init__(self, peer):
        super().__init__(peer)

    def is_investing_in_security(self):
        return bool(random.getrandbits(1))
