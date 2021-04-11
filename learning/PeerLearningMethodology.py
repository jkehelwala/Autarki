class PeerLearningMethodology:
    def __init__(self, peer):
        self.peer = peer
        self.prev_f = 0

    def is_investing_in_security(self):
        raise NotImplementedError("LearningMethodology.is_investing_in_security To be implemented")

    def get_prev_round_f(self):
        return self.prev_f
