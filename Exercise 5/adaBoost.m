data = load('dataCircle (copy).mat','-ascii');
logRegAlpha = 0.005;

[rows, columns] = size(data);
y = data(:,3);

vec = ones([rows, 1]);
x_mat = [vec data(:,1:2)];


weights = repmat(1./rows, [rows 1]);

classifiers = zeros(0,3);
alphas = zeros(0,1);

for i = 1:50
    
    %normalizedWeights = normalize(weights);
    theta = logisticRegression(data, logRegAlpha, weights);
    classifiers = [classifiers; theta'];
    [ epsilon, alpha, weights ] = evaluateAndComputeNewDistribution(x_mat, theta, y, weights);
    alphas = [alphas; alpha];
end

predictions = zeros(0,1);

for i = 1:size(classifiers)
   classifier = classifiers(i,:);
   intermediate = x_mat * classifier';
   h = logsig(intermediate);
   prediction = alphas(i) * round(h);
   predictions = [predictions; prediction];
end
finalClassifications = sign(sum(predictions));

% adjusted labels
y_adj = y * 2 - 1;

performance = mean(finalClassifications == y_adj);


for i = 1:size(classifiers)
    fplot(@(x) -1*(classifiers(i,1)+ classifiers(i,2)*x)/classifiers(i,3), [-10 10]); hold on;
end
positive = data(find(data(:,3) == 1),:);
negative = data(find(data(:,3) == 0),:);
scatter(positive(:,1), positive(:,2), [], 'green'); hold on;
axis([-10 10 -10 10]);
scatter(negative(:,1), negative(:,2), [], 'red'); hold off;


