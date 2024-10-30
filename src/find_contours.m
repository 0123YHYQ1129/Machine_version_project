% find_contours 函数
function contours = find_contours(binary_image)
    % 获取图像的大小
    [rows, cols] = size(binary_image);
    
    % 初始化一个 cell 数组来存储轮廓
    contours = {};  % cell 数组，每个 cell 代表一个轮廓
    contour_count = 1;  % 轮廓计数

    % 遍历图像的每个像素
    for i = 2:rows-1
        for j = 2:cols-1
            % 如果当前像素是前景像素
            if binary_image(i, j) == 1
                % 检查周围是否有背景像素
                if binary_image(i-1, j) == 0 || binary_image(i+1, j) == 0 || ...
                   binary_image(i, j-1) == 0 || binary_image(i, j+1) == 0 || ...
                   binary_image(i-1, j-1) == 0 || binary_image(i-1, j+1) == 0 || ...
                   binary_image(i+1, j-1) == 0 || binary_image(i+1, j+1) == 0
                   
                    % 如果是边界点，检查当前轮廓 cell 数组是否初始化
                    if contour_count > length(contours) || isempty(contours{contour_count})
                        contours{contour_count} = [i, j];  % 初始化轮廓
                    else
                        contours{contour_count} = [contours{contour_count}; [i, j]];  % 追加新点
                    end
                end
            end
        end
    end
end