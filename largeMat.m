% FUNCTION: largeMat
% CREATING DATA FOR TARINING
% Create vectors of training contours, add to matrix to perform PCA later
% Calculated deformations are set to a matrix to perofrm PCA
% ---------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
% ---------

function [] =  largeMat()
clear;
clc;
mat = zeros(200,28);
for k = 22:49
    jpgFilename = strcat('C:\Users\User\Documents\MATLAB\shapes\cs', num2str(k), '.jpg');
    I = imread(jpgFilename);
    imshow(I)

    [F] =   createModelFunc(I,100);
    mat(:,k-20) = F;

end
% I3 = imread('C:\Users\User\Documents\MATLAB\shapes\cs2t3p1e.jpg');
% I2 = imread('C:\Users\User\Documents\MATLAB\shapes\cs3t1p1e.jpg');
% I4 = imread('C:\Users\User\Documents\MATLAB\shapes\cs1et.jpg');
% I1 = imread('C:\Users\User\Documents\MATLAB\shapes\cs6t1p1e.jpg');


% for i = 1:4
%     if i==1
%         [F] =   createModelFunc(I1,100);
%         mat(:,i) = F;
%     elseif i ==2
%         [F] =   createModelFunc(I2,100);
%         mat(:,i) = F;
%     elseif i ==3
%         [F] =   createModelFunc(I3,100);
%         mat(:,i) = F;
%     elseif i ==4
%         [F] =   createModelFunc(I4,100);
%         mat(:,i) = F;
% %     elseif i ==5
% %         F =   createModelFunc(I,I5,100);
% %         mat(:,i) = F;
%      end
% end

figure,
set(gcf,'numbertitle','off','name','Grayscale Image'),
imshow(mat);

v1 = mean(mat,2);
B = repmat(v1,1,28);

save( 'B1.mat' , 'B' );
save( 'mat1.mat' , 'mat' );


% Reconstruction
%bp = cpTrainSim(I, 100);
% createFinalModelFunc(bp1,compData,100);
% length(bp1);
%createFinalModelFunc(bp,compData,100);
%createFinalModelFunc(bp,Compressed_Data,100);
%createFinalModelFunc(bp,mat(:,1),100);
end