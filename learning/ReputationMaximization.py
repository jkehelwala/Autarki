import logging

from learning.PeerLearningMethodology import PeerLearningMethodology


class ReputationMaximization(PeerLearningMethodology):
    def __init__(self, peer):
        super().__init__(peer)
        self.valid_prob = False
        self.prob = -1
        self.r_current = 1
        self.__post_round_calculations()

    def is_investing_in_security(self):  # Inequality 3.8
        limit_divisor = self.peer.benefit * (1 - (2 * self.peer.tolerance))
        logging.debug("ReputationMaximization.is_investing_in_security: Limit: %f",
                     self.r_current)
        if limit_divisor <= 0:
            return True
        reputation_limit = (1 - self.peer.tolerance) / limit_divisor
        logging.debug("ReputationMaximization.is_investing_in_security: Limit:  %f, Current: %f ", reputation_limit,
                      self.r_current)
        if reputation_limit is not None:
            if self.r_current < reputation_limit:
                return True
        return False

    def __post_round_calculations(self):
        blocks_in_round = self.peer.get_blocks_in_round()
        if blocks_in_round is None:
            return
        counted_votes = sum(1 if block.has_voted(self.peer.peer_id) else 0 for block in blocks_in_round)
        self.r_current = counted_votes / self.peer.total_peers
        self.prev_f = len(blocks_in_round) / self.peer.total_peers
        fbr = self.prev_f * self.peer.benefit * self.r_current
        self.valid_prob = fbr >= 1
        if self.valid_prob:
            self.prob = 1 / (2 - (1 / fbr))
        logging.debug("ReputationMaximization.__calc_reputation: prev_f:  %f, Reputation: %f, Valid:  %s, Prob: %f ",
                      self.prev_f, self.r_current, self.valid_prob, self.prob)
