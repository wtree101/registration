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
function [xo,Ot,nS,J_t,rigid,bounce] = register_MI_randb(I_in,J_in)
global I J 
I = I_in;
J = J_in;
%tic
[xo,Ot,nS]= powell(@sim,[0 0 0 1 0 0],0,[],[],[],[],[],300);
%toc 
T1 = [1 0 0;0 1 0;xo(2) xo(3) 1];
T2 = [cos(xo(1)) sin(xo(1)) 0;-sin(xo(1)) cos(xo(1)) 0;0 0 1];
T3 = [xo(4) 0 0;0 xo(4) 0;0 0 1];
T4 = [1 xo(5) 0; xo(6) 1 0;0 0 1];
rigid = T1*T2;  bounce = T3*T4;
T = rigid * bounce;
%T = [xo(1) xo(2) 0;xo(3) xo(4) 0;xo(5) xo(6) 1];
T_form = affine2d(T);
J_t = imwarp(J,T_form,'FillValue',242,'OutputView', imref2d( size(I) ));


end

function obj = sim(xo)
global I J 
%s y_list

T1 = [1 0 0;0 1 0;xo(2) xo(3) 1];
T2 = [cos(xo(1)) sin(xo(1)) 0;-sin(xo(1)) cos(xo(1)) 0;0 0 1];
T3 = [xo(4) 0 0;0 xo(4) 0;0 0 1];
T4 = [1 xo(5) 0; xo(6) 1 0;0 0 1];
rigid = T1*T2;  bounce = T3*T4;
T = rigid * bounce;T_form = affine2d(T);

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