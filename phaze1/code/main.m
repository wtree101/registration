%% 清除所有数据
clc; clear all; close all
%% 记录时间
tic

%% 参数设置
% 彩色图所在文件夹名称
para.fold_name = 'original_picture';
% gif名称
para.gif_name = 'test';
% 背景颜色
para.background = 0.95;
% 参照图像
para.reference = 15;

%% SURF + RANSAC
% 读入第一张图片
g1_col = imread(['..\', para.fold_name, '\', num2str(500 + 1), '_same_size.jpg']);
g1_col = im2double(g1_col);

% 转成灰度图
g1_gray = rgb2gray(g1_col);

% 中值滤波，平滑细胞核的黑色斑点
g1_gray = medfilt2(g1_gray, [5, 5], 'symmetric');

% SURF特征匹配
g1_point  = detectSURFFeatures(g1_gray);
[g1_feature, g1_valid_points] = extractFeatures(g1_gray, g1_point);

% 估计仿射变换
T{1} = eye(3);

% 读入第二张到最后一张图片
for i = 2:30
    % 读入图片
    g2_col = imread(['..\', para.fold_name, '\', num2str(500 + i), '_same_size.jpg']);
    g2_col = im2double(g2_col);
    
    % 转成灰度图
    g2_gray = rgb2gray(g2_col);
    
    % 中值滤波，平滑细胞核的黑色斑点
    g2_gray = medfilt2(g2_gray, [5, 5], 'symmetric');
    
    % SURF特征匹配
    g2_point  = detectSURFFeatures(g2_gray);
    [g2_feature, g2_valid_points] = extractFeatures(g2_gray, g2_point);
    
    feature_maching = matchFeatures(g1_feature, g2_feature);
    g1_matched_points = g1_valid_points(feature_maching(:,1), :);
    g2_matched_points = g2_valid_points(feature_maching(:,2), :);
    
    % 估计仿射变换
    tform = estimateGeometricTransform(g1_matched_points, g2_matched_points,...
        'projective', 'MaxNumTrials', 10000, 'MaxDistance', 1.5, 'Confidence', 99);
    T{i} = tform.T;
    
    % g2复制到g1
    g1_col = g2_col;
    g1_feature = g2_feature;
    g1_valid_points = g2_valid_points;
end

%% 画gif
im_outputview = imref2d(size(g2_gray));
for i = 1:30
    im = imread(['..\', para.fold_name, '\', num2str(500 + i), '_same_size.jpg']);
    im = im2double(im);
    
    if i < para.reference
        temp_trans = eye(3);
        for j = i+1:para.reference
            temp_trans = T{j} * temp_trans;
        end
        tform.T = temp_trans;
        
        index = im_gmm(im,4);
        im = im_front(im, index);
        im_trans = imwarp(im, tform, 'OutputView', im_outputview);
        im_trans = black2gray(im_trans, para.background);
    elseif i == para.reference
        index = im_gmm(im,4);
        im = im_front(im, index);
        im_trans = black2gray(im, para.background);
    else
        temp_trans = eye(3);
        for j = para.reference+1:i
            temp_trans = T{j} * temp_trans;
        end
        temp_trans = inv(temp_trans);
        temp_trans(1:2, 3) = 0;
        temp_trans(3, 3) = 1;
        tform.T = temp_trans;
        
        index = im_gmm(im,4);
        im = im_front(im, index);
        im_trans = imwarp(im, tform, 'OutputView', im_outputview);
        im_trans = black2gray(im_trans, para.background);
    end
    
    if i == 1
        h = figure;
        imshow(im_trans); title('第501号切片')
        frames = getframe(h); 
        im_frame = frame2im(frames); 
        [im_ind, cm] = rgb2ind(im_frame, 256);
        imwrite(im_ind, cm, ['..\outcome\', para.gif_name, '.gif'], 'gif', 'Loopcount', inf);
    else
        imshow(im_trans); title(['第', num2str(500 + i), '号切片'])
        frames = getframe(h); 
        im_frame = frame2im(frames); 
        [im_ind, cm] = rgb2ind(im_frame, 256);
        imwrite(im_ind, cm, ['..\outcome\', para.gif_name, '.gif'], 'gif', 'WriteMode', 'append');
    end
end

%% 记录时间
toc