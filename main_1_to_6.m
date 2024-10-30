% Add necessary functions
addpath('src');

% Read the original image
imagePath = 'data/hello_world.jpg';
originalImage = imread(imagePath);

% Display the original image
figure;
imshow(originalImage);
title('Original Image');

% Get image dimensions
[height, width, ~] = size(originalImage);

% Calculate start and end rows for sub-image extraction
startRow = floor(height / 3);
endRow = floor(height * 2 / 3);

% Extract the sub-image
subImage = originalImage(startRow:endRow, :, :);

% Display the sub-image
figure;
imshow(subImage);
title('Sub-Image');

% Save the sub-image
subImagePath = 'results/sub_image.png';
imwrite(subImage, subImagePath);


% Binarize the sub-image
binaryImage = binarize_image(subImage);

% Display the binary image
figure;
imshow(binaryImage);
title('Binary Image');

% Save the binary image
binaryImagePath = 'results/binary_image.png';
imwrite(binaryImage, binaryImagePath);

% Skeletonize the binary image using Lee's algorithm
skeletonImage = skeletonize(binaryImage, 'lee');

% Display the skeleton image
figure;
imshow(skeletonImage);
title('Skeleton Image');

% Save the skeleton image
skeletonImagePath = 'results/skeleton_image.png';
imwrite(skeletonImage, skeletonImagePath);

% Find contours in the binary image
contours = find_contours(binaryImage);

% Create a figure for displaying the contours
figure;
hold on;

% Set the y-axis to increase downwards to match image coordinates
axis ij;
axis equal;

% Iterate through each contour and plot the points
for k = 1:length(contours)
    contour = contours{k};
    scatter(contour(:, 2), contour(:, 1), 5, 'r', 'filled'); 
end

% Add title and turn off axes
title('Outline(s) of Characters');
axis off;

% Save the outline image
outlineImagePath = 'results/outline_image.png';
saveas(gcf, outlineImagePath);

% Release the hold on the current axes
hold off;

%get labeledImage
labeledImage = segmentAndLabelCharacters(binaryImage);

% Save the labeled image
imshow(labeledImage);
LabeledImagePath = 'results/labeled_image.png';
imwrite(labeledImage, LabeledImagePath); 