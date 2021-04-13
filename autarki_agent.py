import logging.config

from context.Constants import const_none, const_empty_json, const_log_file_name
from context.Network import Network
from ledger.Block import Block

networks = dict()


def init_run(run_number, run_name, total_peers, required_votes, learning_strategy,
             is_cost_heterogeneous, benefit_per_unit_of_cost, minimum_attack_probability, desc_data):
    networks[run_number] = Network(run_number, run_name, total_peers, required_votes, learning_strategy,
                                   is_cost_heterogeneous, benefit_per_unit_of_cost,
                                   minimum_attack_probability, desc_data)
    logfilename = const_log_file_name + "_R-%d.log" % run_number
    logging.config.fileConfig('conf/log.conf', defaults={'logfilename': logfilename})
    logging.debug("======================== %s ============================", logfilename)


def create_peer(run_number, node_id):
    return networks[run_number].create_peer(node_id)


def start_round(run_number, round_number):
    networks[run_number].start_round(round_number)


def transaction(run_number, time):
    return networks[run_number].create_transaction(time)


def propagate_to_peer(run_number, peer_id, transaction_json):
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


def get_proposer(run_number, from_peer=const_none):
    if from_peer == const_none:
        logging.debug("agent.get_proposer: First")
        return networks[run_number].get_proposer()
    logging.debug("agent.get_proposer: Other")
    return networks[run_number].get_peer(from_peer).get_proposer()


def complete_proposer_transfer(run_number, from_peer, to_peer):
    logging.debug("agent.complete_proposer_transfer: %s to %s", from_peer, to_peer)
    networks[run_number].get_peer(to_peer).accept_proposer_position()
    if from_peer != const_none:
        networks[run_number].get_peer(from_peer).proposer_transfer_complete()


# Block Proposal
def get_new_block(run_number, proposer_id, time_in_ticks):
    return networks[run_number].get_peer(proposer_id).propose_block(int(time_in_ticks))


def propagate_block_to_peer(run_number, peer_id, block_json):
    if block_json == const_empty_json or block_json == "":
        logging.debug("agent.propagate_block_to_peer: Empty Json. %s", peer_id)
        return [False, ""]
    network = networks[run_number]
    blockchain_up_to_date, from_to_index = network.get_peer(peer_id).update_current_block(block_json)
    if not blockchain_up_to_date:
        logging.debug("agent.propagate_block_to_peer: Needs to update Blockchain.")
        return [False, from_to_index]
    return [True, network.get_peer(peer_id).get_current_block_json()]


def blockchain_request(run_number, requesting_peer, responding_peer, index_from, index_to):
    network = networks[run_number]
    blockchain_slice = network.get_peer(responding_peer).get_blockchain_slice(index_from, index_to)
    updated_up_to = network.get_peer(requesting_peer).set_blockchain_slice(index_from, blockchain_slice)
    return updated_up_to == index_to


def log_agent_chains(run_number):
    networks[run_number].log_network_chain()


def notify_proposer(run_number, proposer, added_by_peer):
    networks[run_number].get_peer(proposer).collect_added_vote(added_by_peer)


def check_proposed_block_status(run_number, proposer):
    return networks[run_number].get_peer(proposer).check_proposed_block_status()


def get_no_of_votes(current_block):
    try:
        votes = Block.from_json(current_block).vote_count()
    except TypeError:
        votes = 0
    return votes


def get_no_of_attackers_tolerable(run_number):
    return networks[run_number].no_of_attackers_tolerable()


if __name__ == '__main__':
    # init_run(0)
    # logging.debug("test")
    exit()
