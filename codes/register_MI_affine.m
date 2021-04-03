% Testing powell, by using test10 (problem found on Edgar & Himmelblau, 1988)
%
% by Giovani Tonel (giotonel@enq.ufrgs.br)
%
% [xo,Ot,nS]=powell('test10',[-1.2, 1],0,[],[],[],[],[],300)
% 
% xo = 
%   1.0e-018 *
% 
%     0.1599
%    -0.0652
% 
% 
% Ot =  1.2742e-037
% 
% 
% nS = 87
function [xo,Ot,nS,J_t] = register_MI_affine(I_in,J_in)
global I J 
I = I_in;
J = J_in;
%tic
[xo,Ot,nS]= powell(@sim,[1 0 0 1 0 0],0,[],[],[],[],[],300);
%toc 

%T = powell(@sim,[1 0 0 1 0 0],0,[],[],[],[],[],300);
T = [xo(1) xo(2) 0;xo(3) xo(4) 0;xo(5) xo(6) 1];
T_form = affine2d(T);
J_t = imwarp(J,T_form,'FillValue',242,'OutputView', imref2d( size(I) ));


end

function obj = sim(x)
global I J 
%s y_list

T = [x(1) x(2) 0;x(3) x(4) 0;x(5) x(6) 1];
T_form = affine2d(T);

J_t = imwarp(J,T_form,'FillValue',242,'OutputView', imref2d( size(I) ));
%obj = -corr(double(I(:)),double(J_t(:)));
%obj = sum(  (double(I(:))-double(J_t(:))).^2 ); %SSD sum of square
obj = -MI(double(I(:)),double(J_t(:)));
% if mod(s,10)==0
% imshowpair(I,J_t)
% title(['iteration=',num2str(s)]);
% picname=['tmpfig4\' num2str(s) '.jpg'];
% %set(gca,'FontSize',20)
% saveas(gcf,picname,'jpg');
% end
% 
% display(s)
% display(obj)
% s = s+1;
% y_list = [y_list obj];
end