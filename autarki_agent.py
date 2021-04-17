import logging.config

from context.Constants import const_log_file_name
from context.Network import Network

networks = dict()


def init_run(run_number, run_name, total_peers, required_votes, learning_strategy,
             is_cost_heterogeneous, benefit_per_unit_of_cost, minimum_attack_probability, desc_data):
    networks[run_number] = Network(run_number, run_name, total_peers, required_votes, learning_strategy,
                                   is_cost_heterogeneous, benefit_per_unit_of_cost,
                                   minimum_attack_probability, desc_data)
    logfilename = const_log_file_name + "_R-%d.log" % run_number
    logging.config.fileConfig('conf/log.conf', defaults={'logfilename': logfilename})
    logging.debug("=" * 80)
    logging.debug("Log : %s", logfilename)
    logging.debug("Run : %s", run_name)
    logging.debug("Peers : %s", total_peers)
    logging.debug("Required Votes : %s", required_votes)
    logging.debug("Learning Strategy : %s", learning_strategy)
    logging.debug("Heterogeneous Cost : %s", is_cost_heterogeneous)
    logging.debug("Benefit per unit of cost : %s", benefit_per_unit_of_cost)
    logging.debug("Min Attack Probability : %s", minimum_attack_probability)
    logging.debug("Other: %s", desc_data)
    logging.debug("=" * 80)


def create_peer(run_number, node_id):
    return networks[run_number].create_peer(node_id)


def start_round(run_number, round_number):
    networks[run_number].start_round(round_number)


def transaction(run_number, time):
    return networks[run_number].create_transaction(time)


def propagate_txn_to_peer(run_number, peer_id, transaction_json):
    network = networks[run_number]
    network.get_peer(peer_id).set_transactions(transaction_json)
    return network.get_peer(peer_id).get_transactions_json()


def attack_agent(run_number, peer_id):
    return networks[run_number].get_peer(peer_id).set_under_attack()


def remove_attacker_influence(run_number, peer_id):
    return networks[run_number].get_peer(peer_id).unset_under_attack()


def get_blocks_to_attack(run_number, curr_round):
    return networks[run_number].get_round(curr_round).get_attacking_rounds()


def set_peer_network_variables(run_number, peer_list):
    peer_set = set(peer_list)
    networks[run_number].set_peer_network_variables(peer_set)


def log_agent_chains(run_number):
    networks[run_number].log_network_chain()


def check_proposed_block_status(run_number, proposer):
    return networks[run_number].get_peer(proposer).check_proposed_block_status()  # TODO Necessity doubtful


def get_no_of_votes(run_number):
    return networks[run_number].get_current_vote_count()


def get_no_of_attackers_tolerable(run_number):
    return networks[run_number].no_of_attackers_tolerable()


# Block Proposal
def get_new_block(run_number, time_in_ticks):
    return networks[run_number].get_new_block(int(time_in_ticks))


def authenticate_and_vote(run_number, voting_peer, proposed_block):
    return networks[run_number].get_peer(voting_peer).authenticate_and_vote(proposed_block)


def notify_server(run_number, voting_peer):
    return networks[run_number].vote_for_block(voting_peer)


def check_block_status(run_number):
    return networks[run_number].check_proposed_block_status()


def get_voted_block_json(run_number):
    return networks[run_number].get_current_block()


def push_voted_block_to_peer(run_number, peer_id, added_block):
    success = networks[run_number].get_peer(peer_id).accept_block_to_chain(added_block)
    return success


# Blockchain Update
def polling_actions(run_number, requesting_peer):  # Combined without Netlogo interaction
    blockchain_length, prev_block_signature, txn_key_list = get_current_transactions_and_blocks(run_number,
                                                                                                requesting_peer)
    expired, missing_block_list_json, missing_txn_list_json = poll_for_data_update(run_number, blockchain_length,
                                                                                   prev_block_signature, txn_key_list)
    if expired:
        set_current_transactions_and_blocks(run_number, requesting_peer, missing_block_list_json, missing_txn_list_json)


def get_current_transactions_and_blocks(run_number, requesting_peer):
    return networks[run_number].get_peer(requesting_peer).get_poll_request_data()


def poll_for_data_update(run_number, blockchain_length, prev_block_signature, txn_key_list):
    return networks[run_number].updated_blockchain_data(blockchain_length, prev_block_signature, txn_key_list)


def set_current_transactions_and_blocks(run_number, requesting_peer, missing_block_list_json, missing_txn_list_json):
    return networks[run_number].get_peer(requesting_peer).update_blockchain(missing_block_list_json,
                                                                            missing_txn_list_json)


if __name__ == '__main__':
    # init_run(0)
    # logging.debug("test")
    exit()
