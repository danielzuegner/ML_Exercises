numberOfFiles = 30;

positives = [];
negatives = [];

y = [];
imageFeatures = [];
channel = 1;
for i = 1:numberOfFiles;
   img = imread(sprintf('positives/p%02d.png',i));
   positives = [positives img];

   y = [y 1];
   features = [gradientFeatures(img) colorMeanFeatures(img)];
 %  features = [histogramFeatures(img)];
  
   imageFeatures = [imageFeatures; features];
    
   img2 = imread(sprintf('negatives/n%02d.png',i));

   negatives = [negatives img2];
   features2 = [gradientFeatures(img2) colorMeanFeatures(img2)];
 %  features2 = [histogramFeatures(img2)];

   imageFeatures = [imageFeatures; features2 ];
   y = [y 0];

end

covariance = computeCovariance(imageFeatures, y);

% both class means
mean_0 = mean(imageFeatures(y == 0,:));
mean_1 = mean(imageFeatures(y == 1,:));

% predict probabilities
F0 = mvnpdf(imageFeatures, mean_0, covariance);
F1 = mvnpdf(imageFeatures, mean_1, covariance);
% positive or negative example?
classification = F1 > F0;
% check if predictions are correct
correct2 = 1- abs(classification - y');
display([F0 F1 correct2]);

figure
scatter(imageFeatures(y==0,1), imageFeatures(y == 0,2)); hold on;
scatter(imageFeatures(y==1,1), imageFeatures(y == 1,2)); hold off;

