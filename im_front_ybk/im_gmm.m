function im_index = im_gmm(im_input, adjust)
    if isa(im_input, 'uint8')
        im_input = im2double(im_input);
    end
    if nargin < 2
        adjust = 6;
    end
    im_index_layer = zeros(size(im_input));
    for i = 1:3
        im_channe = im_input(:, :, i);
        im_hist = imhist(im_channe);
        im_gmm = fitgmdist(im_hist(1:end-1), 2, 'RegularizationValue', 0.01);
        im_background = cluster(im_gmm, im_hist);
        im_background = find(im_background == 2);
        im_background = (im_background - 1)/255;
        temp = ones(size(im_channe));
        temp(im_channe >= min(im_background) - adjust/255 & im_channe <= max(im_background) + adjust/255) = 0;
        im_index_layer(:, :, i) = temp;
    end
    im_index = im_index_layer(:, :, 1) & im_index_layer(:, :, 2) & im_index_layer(:, :, 3);
    im_index = medfilt2(im_index, [11, 11], 'symmetric');
end