%% Gaze detector
% extracció de característiques
% m = sum(sum(I)) / 64*64
% d = distancia entre dos ulls, 0.65*d = area del ull
% 1 script per aprendre i per testejar
% ratio ulls no ulls = 1:10
clc, clear all
imf = dir('C:\Users\Holmez\Downloads\Universitat\4rt Curs 1er Quadri\VC\ShortProject\source-images\*.pgm'); % llista d'imatges amb extensio bmp
ime = dir('C:\Users\Holmez\Downloads\Universitat\4rt Curs 1er Quadri\VC\ShortProject\source-images\*.eye');
n = length(imf); % nombre d'imatges en el directori
images = zeros([2*n,100,100]); % array n imatges de mida 100 x 100
eyeIndex = 1;
for i = 1 : n % N
    namef = imf(i).name;
    im = imread(strcat('C:\Users\Holmez\Downloads\Universitat\4rt Curs 1er Quadri\VC\ShortProject\source-images\', namef));
    
    s = size(im);
    l = length(s);
    if l == 3
        im = rgb2gray(im);
    end
    
    eye_name = ime(i).name; 
    C = importdata(strcat('C:\Users\Holmez\Downloads\Universitat\4rt Curs 1er Quadri\VC\ShortProject\source-images\', eye_name),'');
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

%% store images
n = length(images);
for index = 1 : n
    I = uint8(squeeze(images(index,:,:)));
    imwrite(I, strcat('eyes_', int2str(index), '.pgm'));
    I2 = flip(I ,2);
    imwrite(I2, strcat('eyes_', int2str(index), '_f.pgm'));
end
%% mostrem les imatges
for index = 1 : n
    I =  uint8(squeeze(images(index,:,:))); % squeeze elimina les dimensions que tenen mida 1 (singletons)
    imshow(I,[]);
end