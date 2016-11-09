function prob = probabilityMultiNormalDistribution(x, mean, covariance)
%PROBABILITYMULTINORMALDISTRIBUTION Computes the probability that a given x
%vector belongs to the multi normal distribution given here.

n = numel(mean);

% make the mean matrix bigger to fit all input data
mean_rep = repmat(mean, size(x, 1), 1);

diff = x-mean_rep;

coefficient = 1./sqrt((2*pi)^n * det(covariance));
% diag seems to be more computationally expensive but I did not how to
% achieve better vectorization
e_term = exp(-1/2 * diag(diff * inv(covariance) * diff')); 

prob = coefficient * e_term;

end