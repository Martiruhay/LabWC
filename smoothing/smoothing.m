function [outputImage] = smoothing(inputImageName,smoothRatio)
% gray image smothing function
I = imread(inputImageName);
outputImage = I;
if (mod(smoothRatio,2) == 1)
    [r,c] = size(I);
    offset = ((smoothRatio - 1) / 2);
    for i = offset+1:(r-offset)
       for j = offset+1:(c-offset)
           outputImage(i,j) = smoothPixel(I,offset,smoothRatio,i,j);
       end
    end
else
    disp("ERROR: smoothRatio not an odd number");
end

end

