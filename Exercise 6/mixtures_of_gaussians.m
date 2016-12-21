function [ means, covariances ] = mixtures_of_gaussians( points, n_gaussians )
%MIXTURES_OF_GAUSSIANS Summary of this function goes here
%   Detailed explanation goes here
    
    [rows, cols] = size(points);
    dimension = cols;
    
    % initialize mu and sigmas
    means = (rand([n_gaussians dimension]) - 0.5) * 20; % rows: the means, cols: mean for each dimension
    
    covariances = ones(dimension, dimension, n_gaussians);
    for gauss = 1:n_gaussians
       sigma = rand(dimension, dimension);
       sigma = (sigma*sigma'  - 0.5) * 20;
       covariances(:,:, gauss) = sigma;
    end
    
    weights = rand([rows n_gaussians]);
    % weights per point should sum up to one
    % IS THIS REALLY IMPORTANT?
    weights = weights ./ repmat(sum(weights,2), [1 n_gaussians]);
    
    for k = 1:100
        for i = 1:n_gaussians
            weights(:, i) = mvnpdf(points, means(i, :), covariances(:, :, i));
            
            % phi update
            phis = mean(weights(:, i), 1);

            % means update
            weights_dim = repmat(weights(:, i), 1, dimension);
            normalization_factor = sum(weights_dim, 1);
            means(i, :) = sum(weights_dim .* points, 1) ./ normalization_factor;

            % covariance update
            weights_dim_dim = repmat(weights(:, i), dimension, dimension);
            means_dim = repmat(means, rows, 1);
            cov_update = (weights_dim_dim .* (points - means_dim)' * (points - means_dim)) ./ normalization_factor;
            covariances(:, :, i) = cov_update;
        end
    end
end

