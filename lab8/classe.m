%% Esquema Clássic de classificació d'imatges
%
% Imatge 
% Preprocessat(filtrar soroll, resaltar rellevancies)
% Binaritzat (d'aquells elements importants)
% Segmentació (agrupar els objectes)
% Caracteristiques (extreure característiques de diferents objectes)
% Predictor (obtenir un vector d'observacions i classificar-les)
% Aprenentage (usant treebaggers o altres estructures)
%
%% PREDICT
% Fase I
I = rgb2gray(imread('Chess figures.png'));
BW = I < 128;
BW = medfilt2(BW,[5,5]);
BW = medfilt2(BW,[5,5]);
BW = bwareaopen(BW,40);
CC = bwconncomp(BW);
% hem de obtenir característiques resistents a canvis com
% rotacions i zooms
ext = cell2mat(struct2cell(regionprops(CC,'Extent')));
ecc = cell2mat(struct2cell(regionprops(CC,'Eccentricity')));
conv = cell2mat(struct2cell(regionprops(CC,'ConvexArea')));
sol = cell2mat(struct2cell(regionprops(CC,'Solidity')));
per = cell2mat(struct2cell(regionprops(CC,'Perimeter')));
area = cell2mat(struct2cell(regionprops(CC,'Area')));

convexity = area.^2 ./ conv.^2;
areadivper = area ./ per;
Obs = [ext;ecc;sol;areadivper;convexity]';
C = ['B','H','K','P','Q','R']';
pred = TreeBagger(100,O,C);
% Fase II
[Class,Scores] = predict(pred,O);
