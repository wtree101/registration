function [im_output_col, im_output_gray] = im_front(im_input, index)
    if isa(im_input, 'uint8')
        im_input = im2double(im_input);
    end
    if ~isa(index, 'logical')
        index = logical(index);
    end
    if size(im_input, 3) == 3
        index_col = repmat(index, 1, 1, 3);
    else
        index_col = index;
    end
    im_output_col = index_col .* im_input;
    im_output_gray = rgb2gray(im_output_col);
end