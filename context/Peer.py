import json
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
        self.state = None  # TODO
        self.strategy = None  # TODO

    def start_round(self):
        self.is_under_attack = False
        self.is_protected = False
        self.set_protected()

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
