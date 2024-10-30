% Define folder_path
folder_path = 'data/p_dataset_26';

% Define letter folders
letters = {'D', 'E', 'H', 'L', 'O', 'W', 'R'};

% Initialization
data = [];
labels = [];

% 遍历每个字母文件夹并加载图像
for i = 1:length(letters)
    letter = letters{i};
    letter_folder = fullfile(folder_path, letter);
    
    % get images in letter file
    image_files = dir(fullfile(letter_folder, '*.png'));
    for j = 1:length(image_files)
        % read image
        img = imread(fullfile(letter_folder, image_files(j).name));
        
        % transfer to gray image(if rgb)
        if size(img, 3) == 3
            img = rgb2gray(img);
        end

        img = double(img);
        
        % transfer the image into a vector
        img_vector = img(:)';
        
        % storage
        data = [data; img_vector];
        labels = [labels; letter];
    end
end

% Dataset partitioning(75% for training, 25% for testing) 
cv = cvpartition(labels, 'Holdout', 0.25);
trainIdx = training(cv);
testIdx = test(cv);

trainData = data(trainIdx, :);
trainLabels = labels(trainIdx);
testData = data(testIdx, :);
testLabels = labels(testIdx);

% creat knn model and train it
knn_model = fitcknn(trainData, trainLabels, 'NumNeighbors', 3);

% predict in test dataset
predictedLabels = predict(knn_model, testData);

% caculate the accuracy
accuracy = sum(predictedLabels == testLabels) / length(testLabels);
fprintf('kNN classification accuracy: %.2f%%\n', accuracy * 100);