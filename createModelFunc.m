%FUNCTION: createModelFunc
%Returns Deformation vector by calculating deformations related to
%template.
%-------------------------------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
%-------------------------------


function [M] = createModelFunc(I1,N)

%create vectors and add to a matrix to perform pca
load('bp.mat' , 'bp');
bp2 = cpTrainSim(I1,N); 

M = zeros(2*N,1);

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
vC = zeros(2*length(bp2),1);

for j = 1:length(bp)

    vT(2*j-1,1) = bp(j,1);
    vT(2*j,1) = bp(j,2);
    
    vC(2*j-1,1) = bp2(j,1);
    vC(2*j,1) = bp2(j,2);

end
save('vC.mat', 'vC');
%Calculations................

F = zeros(2*N,1);

for r = 1:length(bp)-1
  
pointC1 = [bp2(r,1),bp2(r,2)];
pointC2 = [bp2(r+1,1),bp2(r+1,2)];
pointT1 = [bp(r,1),bp(r,2)];
pointT2 = [bp(r+1,1),bp(r+1,2)];
    
thetaT1 = angle2Points(pointT1,pointT2);
thetaT1d =thetaT1*180 /pi;

betazC1 = angle2Points(pointC1,pointC2);
betazC1d = betazC1*180 /pi;

vecC1C2 = createVector(pointC1, pointC2);
vecT1T2 = createVector(pointT1, pointT2);

s1 = vectorMag(vecT1T2,vecC1C2);
ang12 = betazC1 -thetaT1;

trans12 = [cos(ang12) sin(ang12); -sin(ang12) cos(ang12)];
def12 = s1*trans12;

p1 = vecT1T2* def12;
F(2*r-1,1) = p1(1,1);
F(2*r,1) = p1(1,2);

%Add to perform PCA

M(2*r-1) = s1*cos(ang12);
M(2*r) = s1*sin(ang12);
end

pointT1 = [bp(N,1),bp(N,2)];
pointT2 = [bp(1,1),bp(1,2)];
    
thetaT1 = angle2Points(pointT1,pointT2);
thetaT1d =thetaT1*180 /pi;

betazC1 = angle2Points(pointC1,pointC2);
betazC1d = betazC1*180 /pi;

vecC1C2 = createVector(pointC1, pointC2);
vecT1T2 = createVector(pointT1, pointT2);

s1 = vectorMag(vecT1T2,vecC1C2);

ang12 = betazC1 -thetaT1;
ang12d = ang12*180 / pi;

M(2*N-1,1) = s1*cos(ang12);
M(2*N,1) = s1*sin(ang12);

trans12 = [cos(ang12) sin(ang12); -sin(ang12) cos(ang12)];

def12 = s1*trans12;

p1 = vecT1T2* def12;
F(2*N-1,1) = p1(1,1);
F(2*N,1) = p1(1,2);

F = Epinv*F;

figure,
set(gcf,'numbertitle','off','name','Original Contour(Left Blue) Compressed Contour(Right Red)','Position', [200, 80, 900, 600]),
subplot(1,2,1);
%img = imread('C:\Users\User\Documents\MATLAB\temp.jpg');
%imshow(img); hold on;

for s = 1:length(bp)-1
   pointCT1 = [F(2*s-1,1),F(2*s,1)];
   pointCT2 = [F((2*(s+1))-1,1),F((2*(s+1)),1)];
   edgeCT = createEdge(pointCT1 ,pointCT2); 
   drawEdge(edgeCT, 'b'); hold on;

end

pointCT1 = [F(2*N-1,1),F(2*N,1)];
pointCT2 = [F(1,1),F(2,1)];
   edgeCT = createEdge(pointCT1 ,pointCT2); 
   drawEdge(edgeCT, 'b'); hold on;

camroll(270);
end