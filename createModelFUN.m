% FUNCTION: createModelFUN
% 
% Use compressed data vector and apply vector deformations to template and
% deofrm template contour to represent test contour.
% 
% ---------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
% ---------


function [] = createModelFUN(I1,M,N,num)

% Reconstruction of original image data which are been compressed using PCA

load('bp.mat' , 'bp');
%bp = cpTrainSim(I, N);

%Data calculations..............
%pseudo inverse
E = zeros(2*N,2*N);

for i = 1:2*N

    E(i,i) = -1;

    for k = 3:2*N
        E(k-2,k) = 1;
    end
    E(2*N-1,1) = 1;
    E(2*N,2) = 1;
end

Epinv = pinv(E);

%column vectors..............

vT = zeros(2*length(bp),1);

for j = 1:length(bp)

    vT(2*j-1,1) = bp(j,1);
    vT(2*j,1) = bp(j,2);

end

%Calculations................

F = zeros(2*N,1);

for r = 1:length(bp)-1

    pointT1 = [bp(r,1),bp(r,2)];
    pointT2 = [bp(r+1,1),bp(r+1,2)];

    vecT1T2 = createVector(pointT1, pointT2);

    Ttz = [M(2*r-1) M(2*r); -M(2*r) M(2*r-1) ];

    p1 = vecT1T2* Ttz;
    F(2*r-1,1) = p1(1,1);
    F(2*r,1) = p1(1,2);

end

pointT1 = [bp(N,1),bp(N,2)];
pointT2 = [bp(1,1),bp(1,2)];

vecT1T2 = createVector(pointT1, pointT2);

Ttz = [M(2*N-1) M(2*N); -M(2*N) M(2*N-1) ];

p1 = vecT1T2* Ttz;
F(2*N-1,1) = p1(1,1);
F(2*N,1) = p1(1,2);

F = Epinv*F;

if num ==1
    c = 'b';
else
    c = 'r';
end
subplot(1,2,2)

for s = 1:length(bp)-1
    pointCT1 = [F(2*s-1,1),F(2*s,1)];
    pointCT2 = [F((2*(s+1))-1,1),F((2*(s+1)),1)];
    edgeCT = createEdge(pointCT1 ,pointCT2);
    drawEdge(edgeCT, c); hold on;

end

pointCT1 = [F(2*N-1,1),F(2*N,1)];
pointCT2 = [F(1,1),F(2,1)];
edgeCT = createEdge(pointCT1 ,pointCT2);
drawEdge(edgeCT,c); hold on;

end