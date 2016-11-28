function [ normalized ] = normalize( distribution )

normalized = distribution - mean(distribution) + 1;


end

