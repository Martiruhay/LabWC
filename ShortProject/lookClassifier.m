clc, clear all
imf = dir('D:\ShortProject\source-images\*.pgm'); % llista d'imatges amb extensio bmp
n = length(imf); % nombre d'imatges en el directori

for i = 1 : n % N
    namef = imf(i).name;
    im = imread(strcat('D:\ShortProject\source-images\', namef));
    imshow(im);
    
    prompt = 'Do the eyes look at you? [Y/N]';
    look = input(prompt,'s');
    if (look == 'y')
        copyfile(strcat('D:\ShortProject\source-images\', namef), 'D:\ShortProject\_look\');
    else
        copyfile(strcat('D:\ShortProject\source-images\', namef), 'D:\ShortProject\_noLook\');
    end
    
end