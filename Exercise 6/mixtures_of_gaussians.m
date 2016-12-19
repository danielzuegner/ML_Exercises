function [ means, covariances ] = mixtures_of_gaussians( points, n_gaussians )
%MIXTURES_OF_GAUSSIANS Summary of this function goes here
%   Detailed explanation goes here
    
    [rows, cols] = size(points);
    dimension = cols;
    
    % initialize mu and sigmas
    means = (rand([n_gaussians dimension]) - 0.5) * 20; % rows: the means, cols: mean for each dimension
    
    covariances = zeros([dimension dimension n_gaussians]);
    for gauss = 1:n_gaussians
       sigma = rand(dimension,dimension);
       sigma = (sigma*sigma'  - 0.5) * 20;
       covariances(:,:, gauss) = sigma;
    end
    
    weights = rand([rows n_gaussians]);
    % weights per point should sum up to one
    weights = weights ./ repmat(sum(weights,2), [1 n_gaussians]);
    
    % phi for each gaussian
    phis = mean(weights);
    

end

