from learning.HigherThanRequired import HigherThanRequired
from learning.ReputationMaximization import ReputationMaximization


class LearningTypes:
    higher_than_required = "> Required"
    reputation_maximization = "Reputation Maximization"
    regret_matching = "Regret Matching"
    bounded_rationality = "Bounded Rationality"


def get_learning_methodology(choice, peer):
    if peer.get_blocks_in_round() is None:
        return HigherThanRequired(peer)
    elif choice == LearningTypes.reputation_maximization:
        return ReputationMaximization(peer)
    elif choice == LearningTypes.regret_matching:
        raise NotImplementedError("RegretMatching To be implemented")
    elif choice == LearningTypes.bounded_rationality:
        raise NotImplementedError("BoundedRationality To be implemented")
    else:
        raise NotImplementedError("Learning Methodology Invalid")
