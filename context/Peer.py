import json
import random
import uuid

from sortedcontainers import SortedDict


def keys_to_int(x):
    return {int(k): v for k, v in x.items()}  # https://stackoverflow.com/a/53050540


class Peer:
    def __init__(self, who_id):
        self.who_id = who_id  # Constant NetLogo Id For Reference only
        self.peer_id = str(uuid.uuid4())
        self.transactions = SortedDict()
        self.blockchain = list()
        self.is_under_attack = False
        self.is_protected = False
        self.proposers = list()
        self.peer_set = set()
        self.picked_proposer_set = set()
        self.state = None  # TODO
        self.strategy = None  # TODO

    def start_round(self):
        self.is_under_attack = False
        self.is_protected = False
        self.set_protected()
        self.proposers.clear()

    def set_transactions(self, transactions_json):
        if self.is_under_attack:
            return
        json_dict = json.loads(transactions_json, object_hook=keys_to_int)
        self.transactions.update(json_dict)
        self.purge_committed_transactions()

    def get_transactions_json(self):
        return str(json.dumps(self.transactions))

    def get_id(self):
        return self.peer_id

    def purge_committed_transactions(self):
        # TODO get last blocks last timestamp and purge from above). return json
        return

    def set_under_attack(self):
        self.is_under_attack = not self.is_protected
        return self.is_under_attack

    def unset_under_attack(self):
        self.is_under_attack = False

    def set_protected(self):
        self.is_protected = bool(self.who_id % 3 != 1)  # TODO pick value based on strategy and previous blocks

    def set_peer_set(self, peer_set):
        self.peer_set = peer_set

    def get_proposer(self):
        selected_proposer = None
        leftover_proposers = self.peer_set - set(self.proposers) - self.picked_proposer_set
        if len(leftover_proposers) > 0:
            selected_proposer = random.choice(list(leftover_proposers))
        elif len(self.proposers) > 0:
            for candidate in self.proposers:
                if candidate not in self.picked_proposer_set:
                    selected_proposer = candidate
                    break
        if selected_proposer is None:  # Ambiguous situation for when lists are empty
            leftover_proposers = self.peer_set - self.picked_proposer_set
            if len(leftover_proposers) > 0:
                selected_proposer = random.choice(list(leftover_proposers))
            else:
                selected_proposer = random.choice(list(self.peer_set))
        self.picked_proposer_set.add(selected_proposer)
        return selected_proposer

    def proposer_transfer_complete(self):
        self.picked_proposer_set.clear()

    def accept_proposer_position(self):
        self.picked_proposer_set.add(self.peer_id)
