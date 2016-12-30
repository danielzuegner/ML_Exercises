%very useful: http://stackoverflow.com/questions/18904308/given-a-covarince-matrix-generate-a-gaussian-random-variable-in-matlab

num = 100;

% parameters of first gaussian
mean_1 = [10 10];
cov_1  = [5 4; 4 5];
% generate points
gausspoints_1 = mvnrnd(mean_1, cov_1, num);

% parameters of second gaussian
mean_2 = [-3 5];
cov_2 = [5 0; 0 5];
% generate points
gausspoints_2 = mvnrnd(mean_2, cov_2, num);

% parameters of third gaussian
mean_3 = [9 -7];
cov_3 = [5 -3; -3 5];
% generate points
gausspoints_3 = mvnrnd(mean_3, cov_3, num);

scatter(gausspoints_1(:,1), gausspoints_1(:,2), 'filled'), hold on
scatter(gausspoints_2(:,1), gausspoints_2(:,2), 'filled'), hold on
scatter(gausspoints_3(:,1), gausspoints_3(:,2), 'filled'), hold on

ezcontour(@(x,y) mvnpdf([x y], mean_1, cov_1), xlim(), ylim())
ezcontour(@(x,y) mvnpdf([x y], mean_2, cov_2), xlim(), ylim())
ezcontour(@(x,y) mvnpdf([x y], mean_3, cov_3), xlim(), ylim())
title('X~N(\mu,\sigma)')
xlabel('X_1'), ylabel('X_2')

points = [gausspoints_1; gausspoints_2; gausspoints_3];
n_gaussians = 3;
[means, covariances] = mixtures_of_gaussians(points, n_gaussians);

ezcontour(@(x,y) mvnpdf([x y], means(1, :), covariances(:, :, 1)), xlim(), ylim())
ezcontour(@(x,y) mvnpdf([x y], means(2, :), covariances(:, :, 2)), xlim(), ylim())
ezcontour(@(x,y) mvnpdf([x y], means(3, :), covariances(:, :, 3)), xlim(), ylim())
title('Found gaussian bells')
xlabel('X_1'), ylabel('X_2')



