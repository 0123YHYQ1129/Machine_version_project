function skeleton = skeletonize(image, method)

    % Default method
    if nargin < 2
        method = 'lee'; 
    end
    
    % Perform skeletonization using the specified method
    switch lower(method)
        case 'lee'
            % Use MATLAB's 'bwmorph' function with the 'skel' option
            skeleton = bwmorph(image, 'skel', Inf);
        otherwise
            error('skeletonize:UnknownMethod', 'Unsupported skeletonization method: %s', method);
    end
end