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


def temp_print():
    return  # TODO remove temporary debugger method


# if __name__ == '__main__':
#     peer = ContextPeer("test")
#
