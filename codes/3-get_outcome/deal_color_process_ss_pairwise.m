
pos_in = 'D:\WORKPLACE\image_process\resized\resized\phaze2\images_2\imgs\imgs_square\';
pos_out = 'D:\WORKPLACE\image_process\resized\resized\phaze2\outcome_single\outcome6\color_outcome\';

T = [1 0 0;0 1 0;0 0 1];
T = affine2d(T);
%times = 5;
for i=61:5:476 %select 61 to 476
name_fl_input = [num2str(i,'%03d'),'.jpg'];
name_out = [num2str(i,'%03d'),'.jpg'];
color = imread([pos_in,name_fl_input]); % read float fig
%color_t = imresize(color,[3500,3500]);
load(['D:\WORKPLACE\image_process\resized\resized\phaze2\outcome_single\outcome6\data\',num2str(i,'%03d'),'reg.mat'],'o');
T_ss = o.tform;
% get the transform for original high-resolution image from images after downsampling
%just adjust translation part
T_ss.T(3) = T_ss.T(3)*(3500/512);
T_ss.T(6) = T_ss.T(6)*(3500/512);

%accumalate transform from the 1st image to the current image 
T.T = T_ss.T * T.T; % careful! order reverse will get wrong answers!

%get the image registered
J_t = imwarp(color,T,'FillValue',242,'OutputView', imref2d( size(color_t) ));
imwrite(J_t,[pos_out,name_out]);

end
%imshow(J_t)
%imshowpair(color_t,J_t)