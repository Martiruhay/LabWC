clc, clear all
imf = dir('I:\vc\Short Project\*.pgm'); % llista d'imatges amb extensio bmp
n = length(imf); % nombre d'imatges en el directori

for i = 1 : n % N
    namef = imf(i).name;
    im = imread(strcat('I:\vc\Short Project\', namef));
    imshow(im);
    
    prompt = 'Do the eyes look at you? [Y/N]';
    look = input(prompt,'s');
    if (look == 'y')
        copyfile(strcat('I:\vc\Short Project\', namef),'F:\4th_Cours\VC\_look\')
    else
        copyfile(strcat('I:\vc\Short Project\', namef),'F:\4th_Cours\VC\_noLook\')
    end
    
end