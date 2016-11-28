function [ output_args ] = gradientFeatures( img )
%GRADIENTFEATURES Computes gradient features

   % compute gradient magnitude of the input image
   [Gmag,Gdir] = imgradient(rgb2gray(img));
   
   maxGmag = max(Gmag(:));
   stdGmag = std(Gmag(:));
  
   output_args = [maxGmag stdGmag];
end