%% Train Tree Bagger with HoG
clc
noimages = getNotEyes('C:\Users\Holmez\Downloads\Universitat\4rt Curs 1er Quadri\VC\ShortProject\source-images\',getEyeInfo('C:\Users\Holmez\Downloads\Universitat\4rt Curs 1er Quadri\VC\ShortProject\source-images\'));
%%
clc
eyeHOG = zeros(length(images),81);
for i = 1 : length(images)
   eyeHOG(i,:) = HOG(reshape(images(i,:,:),[100 100]));
end
nonEyeHOG = zeros(length(noimages),81);
for i = 1 : length(noimages)
   nonEyeHOG(i,:) = HOG(reshape(noimages(i,:,:),[100 100]));
end

O = vertcat(eyeHOG(1:length(images)-20,:,:),nonEyeHOG(1:length(noimages)-20*18,:,:));
% 20 '1'
% 140 '0'
C = horzcat(repmat(1,1,length(images)-20),repmat(0,1,length(noimages)-20*18));
pred = TreeBagger(100,O,C');
%% Prediction
OO = vertcat(eyeHOG(length(images)-20:length(images),:,:),nonEyeHOG(length(noimages)-20*18+1:length(noimages),:,:));
[ClassPredicted,Scores] = predict(pred,OO);
cat(2,str2num(cell2mat(ClassPredicted)),Scores)
%% Save
save imatgesEyes images
no1 = noimages(1:length(noimages)/2-1,:,:);
no2 = noimages(length(noimages)/2:length(noimages),:,:);
save imatgesNoEyes1 no1
save imatgesNoEyes2 no2
save arbrePredictor pred
%% Load -- TODO
load imatgesEyes images
load imatgesNoEyes1 no1
load imatgesNoEyes2 no2
noimages(1:length(noimages)/2-1,:,:) = no1;
noimages(length(noimages)/2:length(noimages),:,:) = no2;
load arbrePredictor pred