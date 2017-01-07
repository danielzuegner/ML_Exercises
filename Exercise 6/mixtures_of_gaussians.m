function [ means, covariances ] = mixtures_of_gaussians( points, n_gaussians )
%MIXTURES_OF_GAUSSIANS Summary of this function goes here
%   Detailed explanation goes here
    
    [rows, cols] = size(points);
    dimension = cols;
    
    % initialize mu and sigmas
    means = (rand([n_gaussians dimension]) - 0.5) * 20; % rows: the means, cols: mean for each dimension
    
    covariances = ones(dimension, dimension, n_gaussians);
    for gauss = 1:n_gaussians
       while(1)
           sigma = rand(dimension, dimension);
           
           % The below equation A*A' gives only a positive semi-definite matrix
           sigma = (sigma'*sigma - 0.5) * 20;
           
           % Check if all eigenvalues are greater than 0, if so, take that
           % sigma else compute new one
           if(all(eig(sigma) > 0))
               covariances(:,:, gauss) = sigma;
               break;
           end
        end
    end
    
    weights = rand([rows n_gaussians]);
    % weights per point should sum up to one
    % IS THIS REALLY IMPORTANT?
    weights = weights ./ repmat(sum(weights,2), [1 n_gaussians]);
    display(weights);
    phis = mean(weights)
    
    for k = 1:100
        % calculate the denominator of bayes' rule
        density_sum = 0;
        for i = 1:n_gaussians
            density_sum = density_sum + mvnpdf(points, means(i, :), covariances(:, :, i)) * phis(i);
        end
        
        for i = 1:n_gaussians
            display(k)
            %weights(:, i) = mvnpdf(points, means(i, :), covariances(:, :, i));
            density = mvnpdf(points, means(i, :), covariances(:, :, i));
            % bayes' rule
            weights(:, i) = (density * phis(i)) ./ density_sum;

            % phi update
            phis(i) = mean(weights(:, i));

            % means update
            weights_dim = repmat(weights(:, i), 1, dimension);
            normalization_factor = sum(weights_dim, 1);
            means(i, :) = sum(weights_dim .* points, 1) ./ normalization_factor;

            % covariance update
            %weights_dim_dim = repmat(weights(:, i), dimension, dimension);
            means_dim = repmat(means(i,:), rows, 1);
            cov_update = ((weights_dim .* (points - means_dim))' * (points - means_dim)) / normalization_factor(1,1);
            covariances(:, :, i) = cov_update;
        end
    end
end

