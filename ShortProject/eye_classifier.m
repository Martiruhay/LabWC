%% Gaze detector
% extracció de característiques
% m = sum(sum(I)) / 64*64
% d = distancia entre dos ulls, 0.65*d = area del ull
% 1 script per aprendre i per testejar
% ratio ulls no ulls = 1:10
clc, clear all
imf = dir('I:\vc\Short Project\*.pgm'); % llista d'imatges amb extensio bmp
ime = dir('I:\vc\Short Project\*.eye');
n = length(imf); % nombre d'imatges en el directori
images = zeros([2*n,100,100]); % array n imatges de mida 100 x 100
eyeIndex = 1;
for i = 1 : n % N
    namef = imf(i).name;
    im = imread(strcat('I:\vc\Short Project\', namef));
    
    s = size(im);
    l = length(s);
    if l == 3
        im = rgb2gray(im);
    end
    
    namee = ime(i).name; 
    C = importdata(strcat('I:\vc\Short Project\', namee),'');
    K = cell2mat(cellfun(@str2num, C(2), 'UniformOutput', 0));
        
    ce1 = K(1:2);
    ce2 = K(3:4);
    
    dist = pdist([ce1; ce2],'euclidean') * 0.65;
    
    E1 = getEyes(im, ce1, dist);
    E2 = getEyes(im, ce2, dist);
        
    images(eyeIndex,:,:) = imresize(E1,[100 100]);
    images(eyeIndex + 1,:,:) = imresize(E2,[100 100]);
    
    eyeIndex = eyeIndex + 2;
end


%% mostrem les imatges
for index = 1 : n
    I =  uint8(squeeze(images(index,:,:))); % squeeze elimina les dimensions que tenen mida 1 (singletons)
    imshow(I,[]);
end
