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