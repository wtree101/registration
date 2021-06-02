%%
% used to get [imgs_filter\] figure set and [imgs_square\] figure set
%


pos_in = 'D:\WORKPLACE\image_process\resized\resized\phaze2\images_2\imgs\imgs\';
%fixed = imread('D:\WORKPLACE\image_process\resized\resized\502_same_size.jpg');
%fix_num = 502;


tic
%times = 5;
for i = 1:5:496
    disp(i)
  %  disp('fix')
    %disp(fix_num)
    
    name_fl_input = [num2str(i,'%03d'),'.jpg'];
    name_out = [num2str(i,'%03d'),'_filter'];
    floated = imread([pos_in,name_fl_input]); % read float fig
%     for i = 1:times
%         floated=medfilt2(floated,[5,5]);
%     end
    Image_pad = pre_padding(floated);
    floated = pre_single(Image_pad);
    imwrite(Image_pad,['D:\WORKPLACE\image_process\resized\resized\phaze2\images_2\imgs\imgs_square\',[num2str(i,'%03d')],'.jpg']); % [imgs_square\]
    imwrite(floated,['D:\WORKPLACE\image_process\resized\resized\phaze2\images_2\imgs\imgs_filter\',name_out,'.jpg']); %[imgs_filter\]
    
    %save(['D:\WORKPLACE\image_process\resized\resized\phaze2\',name_out,'.mat'],'o')
    
    %imshow(J_t)
    %title(name)
    % if norm(bounce-eye(3))<0.1 %reject process, <0.1 accept
    %  T_form = affine2d(rigid);
    %   J_t = imwarp(floated,T_form,'FillValue',242,'OutputView', imref2d( size(fixed) )); %only rigid
    
end
toc
% for i=502:530
%     str = ['D:\WORKPLACE\image_process\resized\resized\powell\reconstruct',num2str(i), '_reg.jpg'];
%     A=imread(str);
%
%    [I,map]=rgb2ind(A,256);
%     if(i==501)
%         imwrite(A,'movefig.gif','gif','DelayTime',1,'LoopCount',Inf)
%     else
%         imwrite(A,'movefig.gif','gif','WriteMode','append','DelayTime',0.3)
%     end
% end