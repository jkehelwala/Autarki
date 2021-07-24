#!/bin/bash

# netlogo-headless.sh --model autarki.nlogo --setup-file file.xml --experiment experiment1
# Base is same as 1.1.benefits (B=3)

echo "Starting Script"
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 1.1.benefits
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 1.2.min_attack
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 1.3.timeout
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 1.4.no_of_peers
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 2.1.costs
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 2.2.cost_range
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 3.1.tolerance
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 3.2.tolerance_66
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_subset.xml --experiment 3.2.tolerance_80
echo "End Script"
