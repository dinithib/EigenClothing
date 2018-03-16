% FUNCTION: vectorMag
% Calculate vecotr magnitude
% ---------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
% ---------



function ratio = vectorMag(v1,v2)

mag1 = (sqrt((v1(1,1)^2 + v1(1,2)^2)));
mag2 = (sqrt((v2(1,1)^2 + v2(1,2)^2)));
ratio = (mag2/mag1);


end