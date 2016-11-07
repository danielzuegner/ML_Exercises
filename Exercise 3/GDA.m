numberOfFiles = 30;

positives = [];
negatives = [];

imageFeatures = [];
y = [];
histogramEdges = [0, 120, 150, 255];
for i = 1:numberOfFiles;
    img = double(imread(sprintf('positives/p%02d.png',i)));
%    h = double(histcounts(img(:,:,1),histogramEdges));
    [h, edges] = histcounts(img(:,:,1),3);
    h = double(h)
    edges = double(edges)
    mean_1 = mean(mean(img(:,:,1)));
    mean_2 = mean(mean(img(:,:,2)));
    mean_3 = mean(mean(img(:,:,3)));
   % imageFeatures = [imageFeatures; h];
    imageFeatures = [imageFeatures; mean_1 mean_2 mean_3];
    y = [y 1];
    positives = [positives img];
    
    img2 = double(imread(sprintf('negatives/n%02d.png',i)));
 %   h2 = double(histcounts(img2(:,:,1),histogramEdges));
    [h2, edges2] = histcounts(img2(:,:,1),3);
    h2 = double(h2)
    edges2 = double(edges2)
    mean_1 = mean(mean(img2(:,:,1)));
    mean_2 = mean(mean(img2(:,:,2)));
    mean_3 = mean(mean(img2(:,:,3)));
    
  %  imageFeatures = [imageFeatures; h];
    imageFeatures = [imageFeatures; mean_1 mean_2 mean_3 ];
    y = [y 0];

    negatives = [negatives img2];
end

[rows, columns] = size(imageFeatures);


phi = 0.5;
mean_0 = mean(imageFeatures(y == 0,:));
mean_1 = mean(imageFeatures(y == 1,:));

covariance = zeros(columns,columns);
for i=1:rows
    mu = mean_1;
    if y(i) == 0
        mu = mean_0;
    end
    
    val = (imageFeatures(i,:) - mu)' * (imageFeatures(i,:) - mu);
    covariance = covariance + val;
end
covariance = covariance / rows;


F0 = mvnpdf(imageFeatures, mean_0, covariance);
F1 = mvnpdf(imageFeatures, mean_1, covariance);
classification = F1 > F0;
correct2 = 1- abs(classification - y');
