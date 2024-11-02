% find_contours function
function contours = find_contours(binary_image)
    % Get the size of the image
    [rows, cols] = size(binary_image);
    
    % Initialize a cell array to store contours
    contours = {};  % Cell array, each cell represents a contour
    contour_count = 1;  % Contour counter

    % Iterate over each pixel in the image
    for i = 2:rows-1
        for j = 2:cols-1
            % If the current pixel is a foreground pixel
            if binary_image(i, j) == 1
                % Check if there is a background pixel around it
                if binary_image(i-1, j) == 0 || binary_image(i+1, j) == 0 || ...
                   binary_image(i, j-1) == 0 || binary_image(i, j+1) == 0 || ...
                   binary_image(i-1, j-1) == 0 || binary_image(i-1, j+1) == 0 || ...
                   binary_image(i+1, j-1) == 0 || binary_image(i+1, j+1) == 0
                   
                    % If it is a boundary point, check if the current contour cell array is initialized
                    if contour_count > length(contours) || isempty(contours{contour_count})
                        contours{contour_count} = [i, j];  % Initialize the contour
                    else
                        contours{contour_count} = [contours{contour_count}; [i, j]];  % Append new point
                    end
                end
            end
        end
    end
end
