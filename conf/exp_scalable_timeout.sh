#!/bin/bash
# nohup sh conf/exp_scalable_timeout.sh > scalable_timeout.log &

date
../NetLogo/netlogo-headless.sh --model autarki.nlogo --threads 1 --setup-file conf/exp_scalable.xml --experiment 5.2.timeout
echo "Completed: 5.2.timeout"
date
