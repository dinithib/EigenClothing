% FUNCTION: vectorAng
%Inverse tangen in degrees
% ---------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
% ---------


function theta = vectorAng(v1,v2)

ang2  = atand(v2(1,2)/v2(1,1));
ang1  = atand(v1(1,2)/v1(1,1));
ang2
ang1

%---
if(ang2 <0)
%  theta = -1*(theta - 90); 
ang2 = ang2 +180;
end
%---
if(ang1<0)
ang1 = ang1 +180;
%----
%   elseif ang1>0 || ang2<0 || theta < -90
 %   theta = theta + 180;
  %theta
end
%theta = ang2-ang1;
theta = ang2-ang1;
theta
end
