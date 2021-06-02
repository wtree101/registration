
fixed = imread('D:\WORKPLACE\image_process\resized\resized\phaze2\505_filter.jpg');
fix_num = 505;
tic
for i = 510:5:530
    disp(i)
    disp('fix')
    disp(fix_num)
    
    name_fl_input = [num2str(i),'_filter.jpg'];
    name_out = [num2str(i),'_reg'];
    floated = imread(['D:\WORKPLACE\image_process\resized\resized\phaze2\',name_fl_input]); % read float fig
    [xo,Ot,nS,J_t,type] = register_multi_jump(fixed,floated); % I,J
    
    o = struct();
    o.xo = xo; o.Ot = Ot; o.nS = nS; o.type = type;
    o.fixed = fixed;
    o.floated = floated;
    o.J_t = J_t; %save all
    
    save(['D:\WORKPLACE\image_process\resized\resized\phaze2\reconstruct1',name_out,'.mat'],'o')
    
    %imshow(J_t)
    %title(name)
    % if norm(bounce-eye(3))<0.1 %reject process, <0.1 accept
    %  T_form = affine2d(rigid);
    %   J_t = imwarp(floated,T_form,'FillValue',242,'OutputView', imref2d( size(fixed) )); %only rigid
    imshow(J_t,'border','tight','initialmagnification','fit');
    set (gcf,'Position',[0,0,500,500]);  %????500*500
    axis normal;
    saveas(gcf,['D:\WORKPLACE\image_process\resized\resized\powell\reconstruct1\figure\',name_out,'.jpg'],'jpg')
    
    imshowpair(J_t,fixed)
    title(name_out)
    saveas(gcf,['D:\WORKPLACE\image_process\resized\resized\powell\reconstruct1\',name_out,'_compare.jpg'],'jpg')
    
    fixed = J_t;
    fix_num = i;
    %     else
    %         disp(['fail',num2str(i)])
    %     end
    
    
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