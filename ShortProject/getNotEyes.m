function [ images ] = getNotEyes(path, eyeInfo)

imf = dir(strcat(path, '*.pgm'));
n = length(imf);

non_eyes_per_image = 18;
images = zeros([non_eyes_per_image * n,100,100]);

for index = 1 : 10
    namef = imf(index).name;
    I = imread(strcat(path, namef));
    
    [sy, sx] = size(I);
    
    e1 = eyeInfo(index, 1:2);
    e2 = eyeInfo(index, 2:4);
    
    eyes_xmin = min(e1(1), e2(1)) - 50;
    eyes_xmax = max(e1(1), e2(1)) + 50;
    
    eyes_ymin = min(e1(2), e2(2)) - 50;
    eyes_ymax = max(e1(2), e2(2)) + 50;
    
    for i = 1: non_eyes_per_image
        
        xrand = ceil((sx - 100) * rand());
        yrand = ceil((sy - 100) * rand());
        
        if xrand < eyes_xmax && xrand > eyes_xmin && yrand < eyes_ymax && yrand > eyes_ymin
            i = i - 1;
        else
            non_eye = imcrop(I, [xrand yrand 99 99]);
            non_eye_index = (index - 1) * non_eyes_per_image + i;
            images(non_eye_index,:,:) = non_eye;
        end
    end
end
end