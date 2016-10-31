data = dlmread('data.txt',' ');

alpha = 0.005;

theta = logisticRegression(data, alpha);

positive = data(find(data(:,3) == 1),:);
negative = data(find(data(:,3) == 0),:);
figure
scatter(positive(:,1),positive(:,2)); hold on;
scatter(negative(:,1),negative(:,2)); hold on;
display(theta);

fplot(@(x) -1*(theta(1)+ theta(2)*x)/theta(3), [-3 3]); hold off;

