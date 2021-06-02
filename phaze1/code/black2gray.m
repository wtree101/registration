function im_output = black2gray(im_imput, background)
    if nargin < 2
        background = 0.95;
    end
    index = im_imput == 0;
    im_output = im_imput + index .* background;
end