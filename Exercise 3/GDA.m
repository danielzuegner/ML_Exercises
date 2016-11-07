numberOfFiles = 30;

positives = [];
negatives = [];

imageFeatures = [];
y = [];
histogramEdges = [0, 120, 150, 255];
for i = 1:numberOfFiles;
    img = double(imread(sprintf('positives/p%02d.png',i)));
    h = double(histcounts(img(:,:,3),histogramEdges));
    mean_1 = mean(mean(img(:,:,1)));
    mean_2 = mean(mean(img(:,:,2)));
    mean_3 = mean(mean(img(:,:,3)));
   % imageFeatures = [imageFeatures; h];
    imageFeatures = [imageFeatures; mean_1 mean_2 mean_3];
    y = [y 1];
    positives = [positives img];
    
    img = double(imread(sprintf('negatives/n%02d.png',i)));
    h = double(histcounts(img(:,:,3),histogramEdges));
    
    mean_1 = mean(mean(img(:,:,1)));
    mean_2 = mean(mean(img(:,:,2)));
    mean_3 = mean(mean(img(:,:,3)));
    
  %  imageFeatures = [imageFeatures; h];
    imageFeatures = [imageFeatures; mean_1 mean_2 mean_3];
    y = [y 0];

    negatives = [negatives img];
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
correct2 = classification - y';

%for i=1:rows
%    p_0 = ((2*pi).^1.5 * ab)
    
%end


%h = histcounts(positives(:,:,1),3);

%figure
%histogram(positives(:,:,2),3);

%figure
%histogram(positives(:,:,3),3);

%figure
%histogram(negatives(:,:,1),3);

%figure
%histogram(negatives(:,:,2),3);

%figure
%histogram(negatives(:,:,3),3);
