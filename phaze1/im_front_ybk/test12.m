% 读入图片
g1_col = imread(['.\', para.fold_name, '\', num2str(515), '_same_size.jpg']);

index = im_gmm(g1_col, 2);
[g1_front, g1_gray] = im_front(g1_col, index);
g1_front = black2gray(g1_front);
imshow(g1_front)
