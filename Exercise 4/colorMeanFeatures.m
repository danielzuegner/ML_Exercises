function [ output_args ] = colorMeanFeatures( img )
%COLORMEANFEATURES Calculates means for every color channel

    % compute mean of each channel
    mean_1 = mean(mean(img(:,:,1)));
    mean_2 = mean(mean(img(:,:,2)));
    mean_3 = mean(mean(img(:,:,3)));
    output_args = [mean_1 mean_2 mean_3];

end

