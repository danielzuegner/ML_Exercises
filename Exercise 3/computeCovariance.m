function [ output_args ] = computeCovariance( data, y )
%COMPUTECOVARIANCE Computes covariance matrix for the data

    mean_0 = mean(data(y == 0,:));
    mean_1 = mean(data(y == 1,:));

    [rows, columns] = size(data);
    covariance = zeros(columns,columns);
    for i=1:rows
        mu = mean_1;
        if y(i) == 0
            mu = mean_0;
        end
    
        val = (data(i,:) - mu)' * (data(i,:) - mu);
        covariance = covariance + val;
    end
    output_args = covariance / rows;
end

