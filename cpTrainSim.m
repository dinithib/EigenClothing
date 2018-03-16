% FUNCTION: cpTrainSim
% 
% Get Image 
% Get contour 
% Add markers
% Display to user
% Allow user to select mapping points, rearrange data matrix to start from
% selected point. Return the rearranged matrix.
% ---------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
%----------

function [fig]= cpTrainSim(img , N)


% Get N number of points from imput image contour
%Reduce markers to match the numbers points exactly
%return rearrange point matrix which start from user selected point
%call from conMatrix.m

I = img;
BW = im2bw(I, 0.30);
[B,L] = bwboundaries(BW);
f = figure;

set(gcf,'numbertitle','off','name','Detected COntour','Position', [200, 80, 900, 600]),
imshow(BW);

% Mark Boundaries
for k=1:length(B),
    boundary = B{k};

    plot(boundary(:,2),...
        boundary(:,1),'b','LineWidth',2);

end

camroll(180);
axis off;
saveas(f, 'E:\bw16.png');
I = imread('E:\bw16.png');
I = im2bw(I, 0.8);
imcontour(I);
cropped = im2bw(I, 0.8);

%Smooth image contours
[p,q] = test_smooth_contours(cropped);

%Reduce number of points
h1_fig = plot(p,q);
[cpx, cpy] = addmarkers(h1_fig,N);
cp = vertcat(cpx,cpy);
cp = transpose(cp);

%Allow user to select a point
figure;
scatter(cp(:,1),cp(:,2),3,'m', 'fill');
camroll(270);
dcm_obj = datacursormode(gcf);
set(dcm_obj,'DisplayStyle','datatip',...
    'SnapToDataVertex','off','Enable','on');

disp('Click on a line to display a data tip, then press Return.');
% Wait while the user does this.
pause
c_info = getCursorInfo(dcm_obj);
g = c_info.Position;
Mc(1,1) = g(1);
Mc(1,2) = g(2);
figure(gcf);

Mc1 = horzcat(Mc(1,1),Mc(1,2));

%Get index of user selected points in orginal cp Matrix
cpansTr = cp;
ind1 = find(ismember(cpansTr,Mc1), 1);
l = length(cpansTr);
cpansTr(l,1) = cpansTr(l,1)+ 0.3;
cpansTr(l,2) = cpansTr(l,2)+ 0.3;

% Rearrange matrix in user selected position at top
bpA = cpansTr(ind1:l,1:2);
bpB = cpansTr(1:ind1-1,1:2);
bpC = vertcat(bpA,bpB);

fig = bpC;
end


