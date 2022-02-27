#!/bin/bash
# nohup sh conf/exp_scalable.sh > scalable.log &

date
../NetLogo/netlogo-headless.sh --model autarki.nlogo --setup-file conf/exp_scalable.xml --experiment 5.1.tolerance_scalable
echo "Completed: 5.1.tolerance_scalable"
date
