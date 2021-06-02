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

global I J s y_list
name1 = '520';
name2 = '525';

name = [name2,'on',name1,'jump'];
I = imread(['D:\WORKPLACE\image_process\resized\resized\phaze2\',name1,'_filter.jpg']);
J = imread(['D:\WORKPLACE\image_process\resized\resized\phaze2\',name2,'_filter.jpg']);
s=0; y_list = [];
tic
[xo,Ot,nS]= powell(@sim,[1 0 0 1 0 0],0,[],[],[],[],[],300);
toc 
T = [xo(1) xo(2) 0;xo(3) xo(4) 0;xo(5) xo(6) 1];
T_form = affine2d(T);
J_t = imwarp(J,T_form,'FillValue',242,'OutputView', imref2d( size(I) ));

o = struct();
o.xo = xo; o.Ot = Ot; o.nS = nS; o.Jt = J_t; o.I = I;
save(['D:\WORKPLACE\image_process\resized\resized\powell\outcome2\',name,'.mat'],'o')

plot(-y_list)
%saveas(gcf,['D:\WORKPLACE\image_process\resized\resized\powell\outcome\',name,'.fig'])
xlabel('iteration')
ylabel('MI')
title(name)
saveas(gcf,['D:\WORKPLACE\image_process\resized\resized\powell\outcome2\',name,'.jpg'],'jpg')

imshowpair(J_t,I)
title(name)
saveas(gcf,['D:\WORKPLACE\image_process\resized\resized\powell\outcome2\',name,'reg.jpg'],'jpg')


function obj = sim(x)
global I J s y_list

T = [x(1) x(2) 0;x(3) x(4) 0;x(5) x(6) 1];
T_form = affine2d(T);
J_t = imwarp(J,T_form,'FillValue',242,'OutputView', imref2d( size(I) ));
%obj = -corr(double(I(:)),double(J_t(:)));
obj = -MI(double(I(:)),double(J_t(:)));

% if mod(s,10)==0
% imshowpair(I,J_t)
% title(['iteration=',num2str(s)]);
% picname=['tmpfig\' num2str(s) '.jpg'];
% set(gca,'FontSize',20)
% saveas(gcf,picname,'jpg');
% end

%display(s)
%display(obj)
s = s+1;
y_list = [y_list obj];
end

function mi=MI(a,b)
%Caculate MI of a and b in the region of the overlap part
%??????
[Ma,Na] = size(a);
[Mb,Nb] = size(b);
M=min(Ma,Mb);
N=min(Na,Nb);
%????????
hab = zeros(256,256);
ha = zeros(1,256);
hb = zeros(1,256);
%???
imax = max(max(a));
imin = min(min(a));
if imax ~= imin
a = double((a-imin))/double((imax-imin));
else
a = zeros(M,N);
end
imax = max(max(b));
imin = min(min(b));
if imax ~= imin
b = double(b-imin)/double((imax-imin));
else
b = zeros(M,N);
end
a = int16(a*255)+1;
b = int16(b*255)+1;
%?????
for i=1:M
for j=1:N
indexx = a(i,j);
indexy = b(i,j) ;
hab(indexx,indexy) = hab(indexx,indexy)+1;%?????
ha(indexx) = ha(indexx)+1;%a????
hb(indexy) = hb(indexy)+1;%b????
end
end
%???????
hsum = sum(sum(hab));
index = find(hab~=0);
p = hab/hsum;
Hab = sum(-p(index).*log(p(index)));
%??a????
hsum = sum(sum(ha));
index = find(ha~=0);
p = ha/hsum;
Ha = sum(-p(index).*log(p(index)));
%??b????
hsum = sum(sum(hb));
index = find(hb~=0);
p = hb/hsum;
Hb = sum(-p(index).*log(p(index)));
%??a?b??????????????
mi = Ha+Hb-Hab;
end