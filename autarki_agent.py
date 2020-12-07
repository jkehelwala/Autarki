from context.Constants import const_none, LogConst, const_empty_json
from context.Network import Network

networks = dict()


def init_run(run_number):
    networks[run_number] = Network(run_number)


def create_peer(run_number, node_id):
    return networks[run_number].create_peer(node_id)


def start_round(run_number, round_number, no_blocks_per_round, attack_probability_range):
    networks[run_number].start_round(round_number, no_blocks_per_round, attack_probability_range)


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


def set_peer_network_variables(run_number, peer_list, votes_required):
    peer_set = set(peer_list)
    networks[run_number].set_peer_network_variables(peer_set, (float(votes_required) / 100.00))


def get_proposer(run_number, from_peer=const_none):
    if from_peer == const_none:
        return networks[run_number].get_proposer()
    return networks[run_number].get_peer(from_peer).get_proposer()


def complete_proposer_transfer(run_number, from_peer, to_peer):
    networks[run_number].get_peer(to_peer).accept_proposer_position()
    if from_peer != const_none:
        networks[run_number].get_peer(from_peer).proposer_transfer_complete()


def debug_log(output_var):  # TODO Remove
    LogConst.log(output_var)


# if __name__ == '__main__':
#     peer = ContextPeer("test")
#


# Block Proposal

def get_new_block(run_number, proposer_id, time_in_ticks):
    return networks[run_number].get_peer(proposer_id).propose_block(int(time_in_ticks))


def propagate_block_to_peer(run_number, peer_id, block_json):
    if block_json == const_empty_json:
        return ""
    network = networks[run_number]
    network.get_peer(peer_id).update_current_block(block_json)
    return network.get_peer(peer_id).get_current_block_json()


def print_chains(run_number):
    networks[run_number].print_chains()
