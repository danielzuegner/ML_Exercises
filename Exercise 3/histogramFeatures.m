function [ output_args ] = histogramFeatures( image, channel )
    [h, edges] = histcounts(image(:,:,channel),3);
    output_args = double(h);
end

