#!/bin/bash

# nohup sh conf/exp_superset.sh > superset.log &
# netlogo-headless.sh --model autarki.nlogo --setup-file file.xml --experiment experiment1
# Base is same as 1.1.benefits (B=3)

echo "Starting Script\n"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 0.0.base_random
echo "Completed: 0.0.base_random"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 1.1.benefits
echo "Completed: 1.1.benefits"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 1.2.min_attack
echo "Completed: 1.2.min_attack"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 1.3.timeout
echo "Completed: 1.3.timeout"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --threads 1 --setup-file conf/exp_superset.xml --experiment 1.4.no_of_peers
echo "Completed: 1.4.no_of_peers"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 2.1.costs
echo "Completed: 2.1.costs"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 2.2.cost_range
echo "Completed: 2.2.cost_range"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 3.1.tolerance
echo "Completed: 3.1.tolerance"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 3.2.tolerance_66
echo "Completed: 3.2.tolerance_66"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 3.2.tolerance_80
echo "Completed: 3.2.tolerance_80"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 4.0.rep_max_r20
echo "Completed: 4.0.rep_max_r20"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 4.1.regret_r
echo "Completed: 4.1.regret_r"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 4.2.regret_benefit
echo "Completed: 4.2.regret_benefit"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 4.3.boundedr_r
echo "Completed: 4.3.boundedr_r"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_superset.xml --experiment 4.4.boundedr_benefit
echo "Completed: 4.4.boundedr_benefit"
echo "End Script"
