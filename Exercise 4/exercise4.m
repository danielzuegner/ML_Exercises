
% HIER EUREN LIBSVM-PFAD EINF?GEN
% addpath /Users/danielzuegner/Downloads/libsvm-3.21/matlab

numberOfFiles = 30;

positives = [];
negatives = [];

y = [];
imageFeatures = [];
channel = 1;
for i = 1:numberOfFiles;
   img = imread(sprintf('../Exercise 3/positives/p%02d.png',i));
   positives = [positives img];

   y = [y 1];
   features = [gradientFeatures(img) colorMeanFeatures(img)];
 %  features = [histogramFeatures(img)];
  
   imageFeatures = [imageFeatures; features];
    
   img2 = imread(sprintf('../Exercise 3/negatives/n%02d.png',i));

   negatives = [negatives img2];
   features2 = [gradientFeatures(img2) colorMeanFeatures(img2)];
 %  features2 = [histogramFeatures(img2)];

   imageFeatures = [imageFeatures; features2 ];
   y = [y 0];
end
y_svm = y' * 2 - 1;
model = svmtrain(y_svm, imageFeatures, '-c 1 -g 0.07 -t 3');

[predict_label, accuracy, dec_values] =  svmpredict(y_svm, imageFeatures, model);

