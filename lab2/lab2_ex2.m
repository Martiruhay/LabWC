function lab2_ex2(inputImage, fractions)
% generate histogram of an image

[r, c] = size(inputImage);

histogram = zeros(fractions, 1);

for x = 2:(r-1)
    for y = 2:(c-1)
        amm = inputImage(x,y);
        index = ceil(amm/fractions);
        if(index <= 0)
            index = 1;
        end
        histogram(index) = histogram(index) + 1;
    end
    plot(histogram);
end

end

