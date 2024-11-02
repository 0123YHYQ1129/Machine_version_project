function labeledImage = segmentAndLabelCharacters(binaryImage)
%检查输入是否为二值图像
if ~islogical(binaryImage)
    error('Input image must be a binary image (logical matrix).');
end


% Label connected components (characters)
[labeledComponents, numComponents] = bwlabel(binaryImage, 4); % 8-connectivity

% Create a colormap with distinct colors for each component
colormap = rand(numComponents, 3); % Generate random RGB colors

% Initialize the labeled image (RGB)
labeledImage = zeros(size(binaryImage, 1), size(binaryImage, 2), 3);

% Assign colors to each component
for i = 1:numComponents
    % Find the pixels belonging to the current component
    [rows, cols] = find(labeledComponents == i);

    % Assign the corresponding color to these pixels
    for j = 1:length(rows)
        labeledImage(rows(j), cols(j), :) = colormap(i, :);
    end
end

% Convert the labeled image to uint8 for display
labeledImage = uint8(labeledImage * 255);


% Display the labeled image (optional)
figure;
imshow(labeledImage);
title('Segmented and Labeled Characters');

end