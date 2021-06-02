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
function [xo,Ot,nS,J_t,type] = register_multi_jump(I_in,J_in)
global I J 
I = I_in;
J = J_in;
functions_list = {@register_MI_affine,@register_MI_randb};

for i=1:length(functions_list)
    f = functions_list{i};
    [xo,Ot,nS,J_t]= f(I,J);
    success = is_successful(xo,Ot,nS,i);
    if success == 1
        type = i;
        break;
    end
end
 %tic
if (success==0)
    disp('all failed')
    keyboard
end
%toc 


end


function success= is_successful(xo,Ot,nS,type) % if successful
   % if (( (type==1 || type==3)&&Ot<8.0140e+09) || ( (type==2 || type==4) && Ot<-0.845))
    if (Ot>1.15)
        success = 1;
    else
        success = 0;
    end
end