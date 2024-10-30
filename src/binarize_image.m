function binaryImage = binarize_image(inputImage, threshold)
    % If no threshold is provided, use the default value of 128
    if nargin < 2
        threshold = 128;
    end

    % Check if the image is RGB (i.e., has 3 channels)
    if size(inputImage, 3) == 3
        % Convert RGB image to grayscale
        inputImage = rgb2gray(inputImage);
    end

    % Get image size
    [height, width] = size(inputImage);

    % Initialize the binary image
    binaryImage = zeros(height, width, 'logical');

    % Loop through all the pixels
    for row = 1:height
        for col = 1:width
            % Binarize the pixel based on the threshold
            if inputImage(row, col) > threshold
                binaryImage(row, col) = 1;
            else
                binaryImage(row, col) = 0;
            end
        end
    end
end