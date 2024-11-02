function thinnedImage = zhangSuenThinning(binaryImage)
    % 确保输入图像是二值图像（仅包含0和1）
    thinnedImage = logical(binaryImage);
    
    % 获取图像的尺寸
    [rows, cols] = size(thinnedImage);
    
    % 初始化标记，用于标记需要删除的像素
    changing = true;
    
    % 当图像不断变化时，继续迭代处理
    while changing
        changing = false;
        
        % 第一步：标记需要删除的像素
        marker1 = false(rows, cols);
        
        for i = 2:rows-1
            for j = 2:cols-1
                P = getNeighbors(thinnedImage, i, j);
                if thinnedImage(i,j) == 1 && ...
                   (2 <= sum(P(1:8)) && sum(P(1:8)) <= 6) && ...
                   (count01Transitions(P) == 1) && ...
                   (P(2) == 0 || P(4) == 0 || P(6) == 0) && ...
                   (P(4) == 0 || P(6) == 0 || P(8) == 0)
                    marker1(i,j) = true;
                end
            end
        end
        
        % 删除在第一步中标记的像素
        thinnedImage(marker1) = 0;
        
        % 第二步：标记需要删除的像素
        marker2 = false(rows, cols);
        
        for i = 2:rows-1
            for j = 2:cols-1
                P = getNeighbors(thinnedImage, i, j);
                if thinnedImage(i,j) == 1 && ...
                   (2 <= sum(P(1:8)) && sum(P(1:8)) <= 6) && ...
                   (count01Transitions(P) == 1) && ...
                   (P(2) == 0 || P(4) == 0 || P(8) == 0) && ...
                   (P(2) == 0 || P(6) == 0 || P(8) == 0)
                    marker2(i,j) = true;
                end
            end
        end
        
        % 删除在第二步中标记的像素
        thinnedImage(marker2) = 0;
        
        % 如果在任何一步中有像素被标记为删除，则继续迭代
        if any(marker1(:)) || any(marker2(:))
            changing = true;
        end
    end
end

function P = getNeighbors(thinnedImage, x, y)
    % 获取 (x, y) 位置像素的8个邻居，以顺时针方向排列
    P = [thinnedImage(x-1,y) thinnedImage(x-1,y+1) thinnedImage(x,y+1) thinnedImage(x+1,y+1) ...
         thinnedImage(x+1,y) thinnedImage(x+1,y-1) thinnedImage(x,y-1) thinnedImage(x-1,y-1)];
end

function count = count01Transitions(P)
    % 计算邻居数组 P 中 0 到 1 的过渡次数
    count = 0;
    for k = 1:7
        count = count + (P(k) == 0 && P(k+1) == 1);
    end
    % 检查 P(8) 到 P(1) 的过渡
    count = count + (P(8) == 0 && P(1) == 1);
end