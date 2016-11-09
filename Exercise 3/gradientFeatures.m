function [ output_args ] = gradientFeatures( img )
%GRADIENTFEATURES Summary of this function goes here
%   Detailed explanation goes here

    % compute gradient magnitude of the input image
   [Gmag,Gdir] = imgradient(rgb2gray(img));
%   imshow(uint8(Gmag));
   maxGmag = max(reshape(Gmag, 24*24,1));
   stdGmag = std(reshape(Gmag, 24*24,1));
  
   output_args = [maxGmag stdGmag];
end

