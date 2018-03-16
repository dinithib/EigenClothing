% Compress Deformations
% 
% Get new test data and call create model function. 
% Substract mean form vector.
% Perform PCA using retured Eigen vector.
%
% ---------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
%----------

% Project Test contour deformations to PCA space and reduce data.
I5 = imread('C:\Users\User\Documents\MATLAB\MATLAB Code\Shapes\cs21.jpg');

%New  data to PCA 
[V_trans,Bmean] = pcaCalc();
[vNewData] =   createModelFunc(I5,100);
normNewData = vNewData - Bmean(:,1);

%vNewData_trans = transpose(normNewData);
pcaData =  vpa(V_trans*normNewData);
OriginalpcaData = vpa(transpose(V_trans)*pcaData , 16);
OriginalpcaData = double(OriginalpcaData);
OriginalpcaData  = OriginalpcaData  + Bmean(:,1);
createModelFUN(I5 , OriginalpcaData ,100 ,1);


%Compress Data
Reduced_V = transpose(V_trans);
g = zeros(200,196);
Reduced_V(:,1:196) = g;

pcaDataRed =  vpa(transpose(Reduced_V)*normNewData);
RedpcaData = vpa(Reduced_V*pcaDataRed , 16);
RedpcaData = double(RedpcaData);
RedpcaData  = RedpcaData  + Bmean(:,1);

%END COMPRESS DATA
createModelFUN(I5 , RedpcaData ,100 , 2);
camroll(270);

