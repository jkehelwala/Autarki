import random
import string


class Transaction:
    def __init__(self, issue_time):
        self.id = issue_time
        self.data = ''.join(random.choices(string.ascii_uppercase + string.digits, k=4))
        # str(uuid.uuid4())[:4] # TODO NOTE time consuming

    def get_transaction(self):
        return '{"%s":"%s"}' % (self.id, self.data)

    def get_transaction_json(self):
        return self.get_transaction()

