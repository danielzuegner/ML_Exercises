data = load('dataCircle (copy).mat','-ascii');
logRegAlpha = 0.005;
dataSubsetCount = 80;

dataSub = data(1:dataSubsetCount,:);
numbers = 1:dataSubsetCount;
dataSub = [dataSub numbers'];

[rows, columns] = size(dataSub);
y = dataSub(:,3);

vec = ones([rows, 1]);
x_mat = [vec dataSub(:,1:2)];


weights = repmat(1./rows, [rows 1]);
classifiers = zeros(0,4);
alphas = zeros(0,1);


error_vec = zeros(0,1);
wronglyClassifiedIndices = ones(rows,1);
for i = 1:500

    % only select data points that were wrongly classified
    % in the previous iteration
    data_subset = dataSub(logical(wronglyClassifiedIndices),:);
    
    % run logistic regression
    theta = logisticRegression(data_subset, logRegAlpha);
    
    % run classifier on data subset
    intermediate = data_subset(:,1:3) * theta;
    h = logsig(intermediate);
    prediction = round(h);
    
    % compute indices of wrong classifications
    errors = (prediction ~= y(logical(wronglyClassifiedIndices)));
    
    % compute accuracy of classifier
    accuracy = mean(1-errors);
    flip = 0;
    if accuracy < 0.5 % if accuracy is <0.5, we flip our classifier
        flip = 1;
        errors = 1 - errors;
    end
    % augment classifier with the 'flip' bit
    theta = [theta; flip];
    
    
    classifiers = [classifiers; theta'];
    [ epsilon, alpha, weights ] = evaluateAndComputeNewDistribution(x_mat, theta, y, weights);
    alphas = [alphas; alpha];
    
    % evaluate
    accuracy = evaluateStrongClassifier(classifiers, x_mat, y, alphas);
    error_vec = [error_vec; 1 - accuracy];
    
    % get 'global' indices of wrong classifications 
    % i.e. indices in our whole dataset (not just in the subset)
    errorIndices = data_subset(logical(errors),4);
    wronglyClassifiedIndices = zeros(rows,1);
    
    % only set those indices to 1, which were wrongly
    % classified in this iteration
    wronglyClassifiedIndices(errorIndices) = 1;
    
end

predictions = zeros(0,1);

for i = 1:size(classifiers)
    classifier = classifiers(i,:);
    theta = classifier(1:3);
    flip = classifier(4);
    intermediate = x_mat * theta';
    h = logsig(intermediate);
    prediction =  sign(h * 2 - 1);
    if flip == 1
        prediction = prediction * -1;
    end
    weightedPrediction = prediction .* alphas(i);
    predictions = [predictions weightedPrediction];
end
finalClassifications = sign(sum(predictions,2));

% adjusted labels
y_adj = y * 2 - 1;

performance = mean(finalClassifications == y_adj);
display(performance);


for i = 1:size(classifiers)
    fplot(@(x) -1*(classifiers(i,1)+ classifiers(i,2)*x)/classifiers(i,3), [-10 10]); hold on;
end
positive = data(data(:,3) == 1,:);
negative = data(data(:,3) == 0,:);
scatter(positive(:,1), positive(:,2), [], 'green'); hold on;
axis([-10 10 -10 10]);
scatter(negative(:,1), negative(:,2), [], 'red'); hold off;


