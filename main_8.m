% Define folder_path
folder_path = 'data/p_dataset_26';

% Define letter folders
letters = {'D', 'E', 'H', 'L', 'O', 'W', 'R'};

% Define parameter ranges for grid search
num_neighbors_range = [1, 2, 3, 4, 5, 8];
resize_sizes = [16, 32, 64, 128, 256];

% Initialize best parameters
best_accuracy = 0;
best_k = 0;
best_size = 0;
results = zeros(length(num_neighbors_range), length(resize_sizes));

% Grid search
for k_idx = 1:length(num_neighbors_range)
    k = num_neighbors_range(k_idx);
    
    for size_idx = 1:length(resize_sizes)
        resize_size = resize_sizes(size_idx);
        
        % Initialize data arrays
        data = [];
        labels = [];
        
        % Load and process images
        for i = 1:length(letters)
            letter = letters{i};
            letter_folder = fullfile(folder_path, letter);
            
            % Get images in letter folder
            image_files = dir(fullfile(letter_folder, '*.png'));
            for j = 1:length(image_files)
                % Read image
                img = imread(fullfile(letter_folder, image_files(j).name));
                
                % Convert to grayscale if RGB
                if size(img, 3) == 3
                    img = rgb2gray(img);
                end
                if resize_size ~= 128
                    img = imresize(img, [resize_size resize_size]);
                end
                img = double(img);
                
                % Convert image to vector
                img_vector = img(:)';
                
                % Store data
                data = [data; img_vector];
                labels = [labels; letter];
            end
        end
        
        % Split dataset
        cv = cvpartition(labels, 'Holdout', 0.25);
        trainIdx = training(cv);
        testIdx = test(cv);
        
        trainData = data(trainIdx, :);
        trainLabels = labels(trainIdx);
        testData = data(testIdx, :);
        testLabels = labels(testIdx);
        
        % Train KNN model
        knn_model = fitcknn(trainData, trainLabels, 'NumNeighbors', k);
        
        % Make predictions
        predictedLabels = predict(knn_model, testData);
        
        % Calculate accuracy
        accuracy = sum(predictedLabels == testLabels) / length(testLabels);
        results(k_idx, size_idx) = accuracy;
        
        % Update best parameters if current accuracy is higher
        if accuracy > best_accuracy
            best_accuracy = accuracy;
            best_k = k;
            best_size = resize_size;
        end
        
        fprintf('K=%d, Size=%d, Accuracy=%.2f%%\n', k, resize_size, accuracy * 100);
    end
end

% Print best results
fprintf('\nBest parameters found:\n');
fprintf('Best K: %d\n', best_k);
fprintf('Best resize_size: %d\n', best_size);
fprintf('Best accuracy: %.2f%%\n', best_accuracy * 100);

% Plot results
figure;
imagesc(resize_sizes, num_neighbors_range, results);
colorbar;
xlabel('Resize Size');
ylabel('Number of Neighbors (K)');
title('Grid Search Results');
colormap('jet');

% Train final model with best parameters
data = [];
labels = [];

for i = 1:length(letters)
    letter = letters{i};
    letter_folder = fullfile(folder_path, letter);
    
    image_files = dir(fullfile(letter_folder, '*.png'));
    for j = 1:length(image_files)
        img = imread(fullfile(letter_folder, image_files(j).name));
        if size(img, 3) == 3
            img = rgb2gray(img);
        end
        img = imresize(img, [best_size best_size]);
        img = double(img);
        img_vector = img(:)';
        data = [data; img_vector];
        labels = [labels; letter];
    end
end

% Train final model with best parameters
cv = cvpartition(labels, 'Holdout', 0.25);
trainIdx = training(cv);
testIdx = test(cv);

trainData = data(trainIdx, :);
trainLabels = labels(trainIdx);
testData = data(testIdx, :);
testLabels = labels(testIdx);

final_model = fitcknn(trainData, trainLabels, 'NumNeighbors', best_k);
final_predictions = predict(final_model, testData);
final_accuracy = sum(final_predictions == testLabels) / length(testLabels);

fprintf('\nFinal model accuracy with best parameters: %.2f%%\n', final_accuracy * 100);