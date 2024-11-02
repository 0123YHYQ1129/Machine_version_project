function thin_image = thin(image, method)
    % Perform skeletonization using the specified method
    switch lower(method)
        case 'lee'
            % Use MATLAB's 'bwmorph' function with the 'thin' option
            thin_image = bwmorph(image, 'thin', Inf);
        case'zhang-suen'
            thin_image = zhangSuenThinning(image);
        otherwise
            error('skeletonize:UnknownMethod', 'Unsupported skeletonization method: %s', method);
    end
end