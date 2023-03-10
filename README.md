# Bile salt export pump (BSEP) - graph convolutional neural network model. 
Supporting information for paper:

Title: "Using a graph convolutional neural network model to identify bile salt export pump inhibitors." 

Authors: AbdulHameed, Mohamed Diwan M.; Liu, Ruifeng; Wallqvist, Anders

Journal: Under Review

## [`data`](https://github.bhsai.net/mabdulhameed/BSEP_GCNN_model/tree/main/data)

Data used for analyses:
1) BSEP data of 925 compounds with SMILES and activity annotation; 
2) Multi-task learning input data-1 includes BSEP, hERG, and BBB. 
3) Multi-task learning input data-2 includes BSEP, hERG, BBB, PDK-1, and HIVpro. 

Multi-task learning input data are provided as one-hot encoded matrix

## [`scripts`](https://github.bhsai.net/mabdulhameed/BSEP_GCNN_model/tree/main/scripts)

Scripts used in this work.

1) train_gcnn_5cv_classification.py

This script trains a 5-fold cross validated graph convolutional neural network model using Chemprop and saves the results.

The GCNN model is trained on BSEP classification task, where the goal is to predict a binary outcome (Active or Inactive). The training data is provided in a CSV file. The model is trained using cross-validation with 5 folds, and the training process is repeated for 30 epochs. An ensemble of 10 models is trained, and the AUC and PR-AUC are used as evaluation metrics. The results of the model training are saved to output directory (eg. /home/user/out_BSEP_result/).

Once the command-line arguments are set up, the script uses the Chemprop library to parse the arguments and train the model using the cross_validate() and run_training() functions. The script outputs mean of the evaluation metric(s) for the trained model.

2) Performance_Metrics_Script.R

This function calculates various performance metrics for binary classification model predictions.
