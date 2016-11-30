data = load('dataCircle (copy).mat','-ascii');
logRegAlpha = 0.005;

[rows, columns] = size(data);
y = data(:,3);

vec = ones([rows, 1]);
x_mat = [vec data(:,1:2)];


weights = repmat(1./rows, [rows 1]);

classifiers = zeros(0,3);
alphas = zeros(0,1);

% free parameter: multiplication factor that indicates how often an entry
% will be duplicated acccording to the distribution
dist_mult = 10;


for i = 1:50
    % duplicate the misclassified data according to the distribution so
    % that the logistic regression is forced into classifying this data
    % correctly.
    duplicate_assignments = round(weights * rows * dist_mult);
    data_new = data;
    for dup = 2:max(duplicate_assignments)
        data_selection = data(duplicate_assignments == dup, :);
        for mult = 1:dup
            data_new = [data_new; data_selection];
        end
    end
    
    [new_rows, ~] = size(data_new);
    display(['Added ', int2str(new_rows - rows), ' lines.'])
    
    %normalizedWeights = normalize(weights);
    %theta = logisticRegression(data_new, logRegAlpha)
    theta = mnrfit(data_new(:, 1:2), data_new(:, 3)+1);
    
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
positive = data(data(:,3) == 1,:);
negative = data(data(:,3) == 0,:);
scatter(positive(:,1), positive(:,2), [], 'green'); hold on;
axis([-10 10 -10 10]);
scatter(negative(:,1), negative(:,2), [], 'red'); hold off;


