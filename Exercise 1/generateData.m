x = rand(100,1);
epsilon = rand(100,1) * 0.2 - 0.1;
y = sin(2*pi*x) + epsilon;

data = [x,y];

polynomial = 4;
theta = stochasticGradientDescent(data, polynomial, 0.005);

exponents = [0:polynomial];
%x_matrix = repmat(x,1,polynomial + 1);
result = bsxfun(@power, x, exponents);
yhat = result * theta';
figure
scatter(data(:,1), data(:,2)); hold on;
scatter(x,yhat); hold off;