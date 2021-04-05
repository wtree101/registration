function im_output = black2gray(im_imput, background)
    if nargin < 2
        background = 0.95;
    end
    for i = 1:size(im_imput, 3)
        temp = im_imput(:, :, i);
        temp(temp(:, :) == 0) = background;
        im_output(:, :, i) = temp;
    end
end