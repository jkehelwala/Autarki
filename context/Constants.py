from datetime import datetime

const_empty_json = "{}"
const_log_file_name = datetime.now().strftime("logs/%Y_%m_%d_%H_%M_%S")


class BlockConst:
    index = "i"
    transactions = "transactions"
    timestamp = "timestamp"
    previous_hash = "prev_hash"
    signature = "signature"
    voter_signature = "voter_signature"
    votes = "votes"
    proposer = "proposer"
