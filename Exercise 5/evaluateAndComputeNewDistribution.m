function [ epsilon, alpha, distribution ] = evaluateAndComputeNewDistribution( data, classifier, labels, weights)
    theta = classifier(1:3);
    flip = classifier(4);
    intermediate = data * theta;
    h = logsig(intermediate);
    prediction = round(h);
    if flip == 1
        prediction = 1 - prediction;
    end
    errors = (prediction ~= labels);
    
    errorsWeighted = errors .* weights;
    
    % change prediction and labels to range [-1,1]
    prediction_1 = 2 * prediction - 1;
    labels_1 = 2 * labels - 1;
    
    epsilon = sum(errorsWeighted);
    alpha = 0.5 * log((1 - epsilon)/(epsilon));
    
    
    ex = exp(-alpha * labels_1 .* prediction_1);
    z = sum(weights .* ex);
    
    distribution = 1./z * (weights.*ex);

end

