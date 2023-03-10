# -*- coding: utf-8 -*-
"""
Created on Thu Mar  8 11:36:04 2023

@author: mabdulhameed
"""
# This script trains a 5-fold cross validated 
# graph convolutional neural network model using Chemprop and 
# saves the results.

# Import necessary libraries
import chemprop

# Set script arguments
arguments = [
    '--data_path', '/home/user/BSEP_data.csv',
    '--num_folds', '5',
    '--epochs','30',
    '--ensemble_size','10',
    '--extra_metrics','prc-auc',
    '--quiet',
    '--dataset_type', 'classification',
    '--save_dir', '/home/user/out_BSEP_result/'
]

# Parse the arguments and train the model

# Parse arguments using the chemprop library
args = chemprop.args.TrainArgs().parse_args(arguments)
# Run cross-validation with the specified arguments
mean_score, std_score = chemprop.train.cross_validate(args=args, train_func=chemprop.train.run_training)