%% Gaze detector
% extracció de característiques
% m = sum(sum(I)) / 64*64
% d = distancia entre dos ulls, 0.65*d = area del ull
% 1 script per aprendre i per testejar
% ratio ulls no ulls = 1:10
clc, clear all
imf = dir('D:\ShortProject\source-images\*.pgm'); % llista d'imatges amb extensio bmp
ime = dir('D:\ShortProject\source-images\*.eye');
n = length(imf); % nombre d'imatges en el directori
images = zeros([2*n,100,100]); % array n imatges de mida 100 x 100
eyeIndex = 1;

iml = dir('D:\ShortProject\look\*.pgm');
imnl = dir('D:\ShortProject\noLook\*.pgm');
il = 1;
inl = 1;
indexl = 1;
indexnl = 1;
imagesLook = zeros([length(iml),100,100]);
imagesNoLook = zeros([length(imnl),100,100]);
for i = 1 : n % N
    namef = imf(i).name;
    im = imread(strcat('D:\ShortProject\source-images\', namef));
    
    s = size(im);
    l = length(s);
    if l == 3
        im = rgb2gray(im);
    end
    
    eye_name = ime(i).name; 
    C = importdata(strcat('D:\ShortProject\source-images\', eye_name),'');
    K = cell2mat(cellfun(@str2num, C(2), 'UniformOutput', 0));
        
    ce1 = K(1:2);
    ce2 = K(3:4);
    
    dist = pdist([ce1; ce2],'euclidean') * 0.65;
    
    E1 = getEyes(im, ce1, dist);
    E2 = getEyes(im, ce2, dist);

    images(eyeIndex,:,:) = imresize(E1,[100 100]);
    images(eyeIndex + 1,:,:) = imresize(E2,[100 100]);
    eyeIndex = eyeIndex + 2;
    
    if namef == iml(il).name
        imagesLook(indexl,:,:) = imresize(E1,[100 100]);
        imagesLook(indexl + 1,:,:) = imresize(E2,[100 100]);
        indexl = indexl + 2;
        il = il + 1;
    else
        if namef == imnl(inl).name
            imagesNoLook(indexnl,:,:) = imresize(E1,[100 100]);
            imagesNoLook(indexnl + 1,:,:) = imresize(E2,[100 100]);
            indexnl = indexnl + 2;
            inl = inl + 1;
        end
    end
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