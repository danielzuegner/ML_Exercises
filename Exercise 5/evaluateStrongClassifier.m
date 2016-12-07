function  accuracy  = evaluateStrongClassifier( classifiers, x_mat, y , alphas)

 predictions = zeros(0,1);
 for i = 1:size(classifiers)
 % get classifier from our set of classifiers
     classifier = classifiers(i,:);
     
     theta = classifier(1:3);
     flip = classifier(4); % flip predictions of this classifier if bit is active
    
     % run our classifier
     intermediate = x_mat * theta';
     h = logsig(intermediate);
     prediction =  sign(h * 2 - 1);
     if flip == 1
         prediction = prediction * -1; % flip prediction
     end
     weightedPrediction = prediction .* alphas(i);
     predictions = [predictions weightedPrediction];
 end
 strongClassifierPredictions = sign(sum(predictions,2));
 % adjusted labels
 y_adj = y * 2 - 1;
 % performance of strong classifier
 accuracy = mean(strongClassifierPredictions == y_adj);


end

