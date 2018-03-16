% FUCNTION:PCA_EigenCloth
% 
% PERFORM PCA ON CLOTHED AND NAMKED IMAGE AND RECONSTRUCT CONTOUR AND RETURN EIGEN CLOTHING RESULTS
% BY APPLYING PCA.
%
% ---------
% Author: Dinithi Bamnuarachchi
% e-mail: mailtodinithi@gmail.com
% created the 02/07/2013.
%----------

function [] = PCA_EigenCloth()
load('Ev.mat' , 'Ev');
EMat = Ev;

% Start PCA
Data_mean = mean(EMat);
[a b] = size(EMat);
Data_meanNew = repmat(Data_mean,a,1);
DataAdjust = EMat - Data_meanNew;
cov_data = cov(DataAdjust);
[V, D] = eig(cov_data);
V_trans = transpose(V);
DataAdjust_trans = transpose(DataAdjust);
FinalData = V_trans * DataAdjust_trans;

% Start Inverse PCA
OriginalData_trans = inv(V_trans) * FinalData;
OriginalData = transpose(OriginalData_trans) + Data_meanNew;
% End Inverse PCA

%Image compression
PCs=input('Enter number of PCs needed?  ');
PCs = b - PCs;
Reduced_V = V;
for i = 1:PCs,
    Reduced_V(:,1) =[];
end
Y=Reduced_V'* DataAdjust_trans;
Compressed_Data=Reduced_V*Y;
Compressed_Data = Compressed_Data' + Data_meanNew;
% End of image compression

figure;
set(gcf,'numbertitle','off','name','Orginal Contour(Left Blue) Compressed Contour(Right Red)','Position', [200, 80, 900, 600]),
subplot(1,2,1)
for i = 1:100
    scatter(OriginalData(2*i-1,1),OriginalData(2*i,1),3,'b','fill'); hold on;
end
camroll(270);
subplot(1,2,2)
for i = 1:100
    scatter(Compressed_Data(2*i-1,1),Compressed_Data(2*i,1),3,'r','fill'); hold on;
    scatter(OriginalData(2*i-1,1),OriginalData(2*i,1),3,'b','fill'); hold on;
end
camroll(270);

% % Test data compression
% load('TestC.mat' , 'TestC');
% testCont = TestC;
% testCont = testCont - Data_meanNew(1,:);
% 
% tPCs=input('Enter number of PCs needed to test data?  ');
% tPCs = b - tPCs;
% Reduced_Vt = V;
% for i = 1:tPCs,
%     Reduced_Vt(:,1) =[];
% end
% Yt=Reduced_Vt'* transpose(testCont);
% RedTest_Data=Reduced_Vt*Yt;
% RedTest_Data = RedTest_Data' + transpose(Data_meanNew(1,:));
% 
% 
% figure;
% set(gcf,'numbertitle','off','name','Test Contour Compressed Image','Position', [200, 80, 900, 600]),
% subplot(1,2,1)
% for i = 1:100
%     scatter(testCont(2*i-1,1),testCont(2*i,1),3,'b','fill'); hold on;
% end
% camroll(270);
% subplot(1,2,2)
% for i = 1:100
%     scatter(RedTest_Data(2*i-1,1),RedTest_Data(2*i,1),3,'r','fill'); hold on;
%     scatter(testCont(2*i-1,1),testCont(2*i,1),3,'b','fill'); hold on;
% end
% camroll(270);

end