const_none = ""
const_empty_json = "{}"

class BlockConst:
    index = "i"
    transactions = "transactions"
    timestamp = "timestamp"
    previous_hash = "prev_hash"
    signature = "signature"
    votes = "votes"
    proposer = "proposer"


class LogConst:
    @classmethod
    def log(cls, str_line):
        print(str_line)