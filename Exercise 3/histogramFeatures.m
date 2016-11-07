function [ output_args ] = histogramFeatures( image, channel )
    binEdges = linspace(100,200, 5);
    h = histcounts(rgb2gray(image),binEdges);
    output_args = double(h);
end

