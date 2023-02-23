

get_perf_metrics_bayesclassif <- function(predictions) {
    # Rename variables for clarity
    predictions$predicted_binary <- predictions$PRED
    predictions$predicted_binary <- predictions$predicted
    predictions$predicted_binary[predictions$predicted_binary < 0.5] <- 0 
    predictions$predicted_binary[predictions$predicted_binary >= 0.5] <- 1
    
    true_positives <- sum(predictions$PROPERTY == 1 & predictions$predicted_binary == 1)
    false_negatives <- sum(predictions$PROPERTY == 1 & predictions$predicted_binary == 0)
    true_negatives <- sum(predictions$PROPERTY == 0 & predictions$predicted_binary == 0)
    false_positives <- sum(predictions$PROPERTY == 0 & predictions$predicted_binary == 1)
    
    sensitivity = true_positives/(true_positives + false_negatives)
    specificity = true_negatives/(true_negatives + false_positives)
    accuracy = (true_positives + true_negatives)/(true_positives + true_negatives + false_positives + false_negatives)
    
    # Calculate AUC
    library(ROCR)
    pred <- prediction(predictions$predicted, predictions$PROPERTY)
    perf_ROC <- performance(pred, "tpr", "fpr")
    AUC <- as.numeric(performance(pred, "auc")@y.values)
    
    # Calculate PR-AUC
    fg <- predictions$predicted[predictions$PROPERTY == 1]
    bg <- predictions$predicted[predictions$PROPERTY == 0]
    pr <- pr.curve(scores.class0 = fg, scores.class1 = bg, curve = TRUE)
    PRAUC <- pr$auc.integral
    
    # Calculate baseline
    baseline <- (true_positives + false_negatives)/nrow(predictions)
    
    # Calculate Matthews correlation coefficient
    mcc_num <- (true_positives * true_negatives - false_positives * false_negatives)
    mcc_den <- (true_positives + false_positives) * (true_positives + false_negatives) * (true_negatives + false_positives) * (true_negatives + false_negatives)
    MATTCORR <- mcc_num / sqrt(mcc_den)
    
    # Calculate Precision, Recall, and F1 score
    precision <- true_positives / (true_positives + false_positives)
    recall <- true_positives / (true_positives + false_negatives)
    F1 <- 2 * (precision * recall) / (precision + recall)
    
    # Return performance metrics as a data frame
    out <- data.frame(
        accuracy = accuracy,
        sensitivity = sensitivity,
        specificity = specificity,
        AUC = AUC,
        PRAUC = PRAUC,
        baseline = baseline,
        MATTCORR = MATTCORR,
        precision = precision,
        recall = recall,
        F1 = F1
    )
    
    return(out)
}