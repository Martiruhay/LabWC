%% Get no eyes
clc
noimages = getNotEyes('C:\Users\Holmez\Downloads\Universitat\4rt Curs 1er Quadri\VC\ShortProject\source-images\',getEyeInfo('C:\Users\Holmez\Downloads\Universitat\4rt Curs 1er Quadri\VC\ShortProject\source-images\'));
%% Train Eye Tree Bagger with HoG
clc
eyeHOG = zeros(length(images),81);
for i = 1 : length(images)
   eyeHOG(i,:) = HOG(reshape(images(i,:,:),[100 100]));
end
nonEyeHOG = zeros(length(noimages),81);
for i = 1 : length(noimages)
   nonEyeHOG(i,:) = HOG(reshape(noimages(i,:,:),[100 100]));
end

eO = vertcat(eyeHOG(1:length(images)-20,:,:),nonEyeHOG(1:length(noimages)-20*18,:,:));
% 20 '1'
% 140 '0'
eC = horzcat(repmat(1,1,length(images)-20),repmat(0,1,length(noimages)-20*18));
eyePred = TreeBagger(100,eO,eC');
%% Eye Prediction
eOO = vertcat(eyeHOG(length(images)-20:length(images),:,:),nonEyeHOG(length(noimages)-20*18+1:length(noimages),:,:));
[eClassPredicted,eScores] = predict(eyePred,eOO);
cat(2,str2num(cell2mat(eClassPredicted)),eScores)
%% Train Look Tree Bagger with HoG
clc
lookHOG = zeros(length(imagesLook),81);
for i = 1 : length(imagesLook)
   lookHOG(i,:) = HOG(reshape(imagesLook(i,:,:),[100 100]));
end
noLookHOG = zeros(length(imagesNoLook),81);
for i = 1 : length(imagesNoLook)
   noLookHOG(i,:) = HOG(reshape(imagesNoLook(i,:,:),[100 100]));
end

lO = vertcat(lookHOG(1:length(imagesLook)-20,:,:),noLookHOG(1:length(imagesNoLook)-20,:,:));
% 20 '1'
% 140 '0'
lC = horzcat(repmat(1,1,length(imagesLook)-20),repmat(0,1,length(imagesNoLook)-20));
lookPred = TreeBagger(100,lO,lC');
%% Look Prediction
lOO = vertcat(lookHOG(length(imagesLook)-20:length(imagesLook),:,:),noLookHOG(length(imagesNoLook)-20:length(imagesNoLook),:,:));
[lClassPredicted,lScores] = predict(lookPred,lOO);
cat(2,str2num(cell2mat(lClassPredicted)),lScores)
%% Save
clc
save imatgesEyes images
no1 = noimages(1:length(noimages)/2-1,:,:);
no2 = noimages(length(noimages)/2:length(noimages),:,:);
save imatgesNoEyes1 no1
save imatgesNoEyes2 no2
save eyePredictor eyePred
save lookPredictor lookPred
save look imagesLook
save noLook imagesNoLook
%% Load -- TODO
clc
load imatgesEyes images
load imatgesNoEyes1 no1
load imatgesNoEyes2 no2
noimages = zeros(length(no1)+length(no2),100,100);
noimages(1:length(noimages)/2-1,:,:) = no1;
noimages(length(noimages)/2:length(noimages),:,:) = no2;
load eyePredictor eyePred
load lookPredictor lookPred
load look imagesLook
load noLook imagesNoLook
