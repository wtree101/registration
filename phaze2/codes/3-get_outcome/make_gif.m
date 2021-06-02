% for i=501:530
%     str = ['D:\WORKPLACE\image_process\resized\resized\',num2str(i), '_same_size.jpg'];
%     A=imread(str);
%     
%    % [I,map]=rgb2ind(A,256);
%     if(i==501)
%         imwrite(A,'movefig.gif','gif','DelayTime',1,'LoopCount',Inf)
%     else
%         imwrite(A,'movefig.gif','gif','WriteMode','append','DelayTime',0.3)    
%     end
% end
pos_in = 'D:\WORKPLACE\image_process\resized\resized\phaze2\outcome_single\outcome6\color_outcome\';
pos_out = 'D:\WORKPLACE\image_process\resized\resized\phaze2\outcome_single\outcome6\gif\';

for i=61:5:476
    name_fl_input = [num2str(i,'%03d'),'.jpg'];
    str = [pos_in,name_fl_input];
    try
        A=imread(str);
    catch
        continue
    end
    %A = rgb2gray(A);
 %  [I,map]=rgb2ind(A,256);
%     if(i==16)
%         imwrite(A,[pos_out,'movefig_2.gif'],'gif','DelayTime',1,'LoopCount',Inf)
%     else
%         imwrite(A,[pos_out,'movefig_2.gif'],'gif','WriteMode','append','DelayTime',0.3)    
%     end
    if i == 61
        h = figure;
        imshow(A); 
        frames = getframe(h); 
        im_frame = frame2im(frames); 
        [im_ind, cm] = rgb2ind(im_frame, 256);
        imwrite(im_ind, cm, [pos_out, 'movefig_2.gif', '.gif'], 'gif', 'Loopcount', inf);
    else
        imshow(A); 
        frames = getframe(h); 
        im_frame = frame2im(frames); 
        [im_ind, cm] = rgb2ind(im_frame, 256);
        imwrite(im_ind, cm, [pos_out, 'movefig_2.gif', '.gif'], 'gif', 'WriteMode', 'append','DelayTime',0.1);
    end
end