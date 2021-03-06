#!/bin/bash
DATASET='cifar_100'
python attack_tf.py $DATASET --save_data=1
for DP in 'dp' 'adv_cmp' 'rdp' 'zcdp'
do
   for EPSILON in 0.1 0.5 1.0 5.0 10.0 50.0 100.0 500.0 1000.0
   do
      for RUN in 1 2 3 4 5
      do
         python attack_tf.py $DATASET --target_model='softmax' --target_l2_ratio=1e-5 --target_privacy='grad_pert' --target_dp=$DP --target_epsilon=$EPSILON --run=$RUN
      done
   done
done
for DP in 'dp' 'adv_cmp' 'rdp' 'zcdp'
do
   for EPSILON in 0.1 0.5 1.0 5.0 10.0 50.0 100.0 500.0 1000.0
   do
      for RUN in 1 2 3 4 5
      do
         python attack_tf.py $DATASET --target_model='nn' --target_l2_ratio=1e-4 --target_privacy='grad_pert' --target_dp=$DP --target_epsilon=$EPSILON --run=$RUN
      done
   done
done
echo done
