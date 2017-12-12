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
    
    eye_name = ime(i).name; 
    C = importdata(strcat('I:\vc\Short Project\', eye_name),'');
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

%% get eye info
ime = dir('I:\vc\Short Project\*.eye');
eyes = [];
n = length(ime);
for index = 1 : n
    eye_name = ime(index).name; 

    data = importdata(strcat('I:\vc\Short Project\', eye_name),'');
    data_mat = cell2mat(cellfun(@str2num, data(2), 'UniformOutput', 0));
    
    ce1 = data_mat(1:2);
    ce2 = data_mat(3:4);
    
    ce = cat(2, ce1, ce2);
    eyes = cat(1, eyes, ce);
end


%% get not-eyes
n = length(images);
% top bot left right
non_eyes_per_section = [6, 6, 12, 12];

for index = 1 : 1
    I = uint8(squeeze(images(index,:,:)));
    [sx, sy] = size(I);
    
    % get the eyes's limits
    eyes_pos = eyes(index);
    
    e1 = eyes_pos(1:2);
    e2 = eyes_pos(1:2);
    
    eyes_xmin = min(e1(1), e2(1));
    eyes_xmax = max(e1(1), e2(1));
    
    eyes_ymin = min(e1(2), e2(2));
    eyes_ymax = max(e1(2), e2(2));
    
    % build the sections
    % xmin xmax ymin ymax
    section_top = [0, sx, 0, eyes_ymin];
    section_bot = [0, sx, eyes_ymax, sy];
    section_left = [0, eyes_xmin, eyes_ymin, sy];
	section_right = [eyes_xmax, sx, eyes_ymin, sy];
    sections = cat(1, section_top, section_bot, section_left, section_right);
    
    for i_chunk = 1 : 4
        
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
