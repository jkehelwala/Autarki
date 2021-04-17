from learning.PeerLearningMethodology import PeerLearningMethodology


class HigherThanRequired(PeerLearningMethodology):
    def __init__(self, peer):
        super().__init__(peer)

    def is_investing_in_security(self):
        return (self.peer.who_id % self.peer.total_peers) <= self.peer.votes_required

