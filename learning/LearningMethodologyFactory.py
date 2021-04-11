from learning.ReputationMaximization import ReputationMaximization
from context.Constants import LearningTypes


def get_learning_methodology(choice, peer):
    if choice == LearningTypes.reputation_maximization:
        return ReputationMaximization(peer)
    elif choice == LearningTypes.regret_matching:
        raise NotImplementedError("RegretMatching To be implemented")
    elif choice == LearningTypes.bounded_rationality:
        raise NotImplementedError("BoundedRationality To be implemented")
    else:
        raise NotImplementedError("Learning Methodology Invalid")
