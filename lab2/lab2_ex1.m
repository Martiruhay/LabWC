function [outputImage] = ex1(inputImage)
% circle the pixel with biggest contrast with its neighbors
im = inputImage;
[r, c] = size(inputImage);
maxContrast = 0;
mCX = -1;
mCY = -1;

for x = 2:(r-1)
    for y = 2:(c-1)

        contrast = [ im(x-1,y-1), im(x-1,y), im(x-1,y+1),...
                      im(x,y-1), im(x,y), im(x,y+1),...
                      im(x+1,y-1), im(x+1,y), im(x+1,y+1)];

        contrast = double(contrast);

        mu = mean(contrast);
        stdDev = std(contrast);
        c = (double(im(x,y)) - mu) / stdDev;
        if maxContrast < c
            mCX = x;
            mCY = y;
            maxContrast = c;
        end
    end
end

outputImage = insertShape(im, 'circle', [mCX, mCY, 5]);
end

