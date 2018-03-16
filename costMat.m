% FUNCTION: costMat
% 
% Calculate cost between contour points
% Use euclidean distance for calcualtions
% ---------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
% ---------



function [CM3] = costMat(cp, ccp)

x = cp(:,1);
y = cp(:,2);
scatter(x, y, 3 ,'fill' , 'b'); hold on;


p = ccp(:,1);
r = ccp(:,2);
scatter(p, r, 3 ,'fill', 'r');
camroll(270);

CM3 = [length(cp), length(ccp)];
if length(cp) >= length(ccp)
    

for g = 1:length(cp)
    a = cp(g,1);
    b = cp(g,2);
    for h = 1: length(ccp)
    c = ccp(h,1);
    d = ccp(h,2);
    
    X = [a,b;c,d];
    dis = pdist(X,'euclidean');
    
    CM3(g,h) = dis;
    
    end
end
else
    for g = 1:length(ccp)
    a = ccp(g,1);
    b = ccp(g,2);
    for h = 1: length(cp)
    c = cp(h,1);
    d = cp(h,2);
    
    X = [a,b;c,d];
    dis = pdist(X,'euclidean');
    
    CM3(g,h) = dis;
    end
    end
end

    

[minval,ind] = min(CM3(:));

[I,J] = ind2sub([size(CM3,1) size(CM3,2)],ind);

end
