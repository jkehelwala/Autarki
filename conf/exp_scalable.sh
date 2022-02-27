#!/bin/bash
# nohup sh conf/exp_scalable.sh > scalable.log &

../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_scalable.xml --experiment 1.4.no_of_peers
echo "Completed: 1.4.no_of_peers"
