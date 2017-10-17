function[SNR] = lab2_ex3(I)
% calculate noise on image rescale

newImage = amp(I, 3);
newImage = red(newImage, 7);

newImage = amp(newImage, 7);
newImage = red(newImage, 3);

%SNR  =  10 log10(Ps/PN)
Ps = standard_dev(newImage, I);
PN = matrix_mean(I);

SNR = 10*log10(Ps/PN);
end

function[ret] = matrix_mean(I)
ret = mean(mean(I));
end

function[ret] = standard_dev(I1, I2)
std1 = std(std(cast(I1, 'double')));
std2 = std(std(cast(I2, 'double')));
ret = std([std1, std2]);
end

function[newI] = red(I, times)
[r, c] = size(I);

newI = zeros(ceil(r / times), ceil(c / times));
timesSampled = zeros(ceil(r / times), ceil(c / times));

for x = 1:(r)
    for y = 1:(c)
        ix = ceil(x/times);
        iy = ceil(y/times);
        newI(ix, iy) = newI(ix, iy) + cast(I(x, y), 'double');
        timesSampled(ix, iy) = timesSampled(ix, iy) + 1;
    end
end
newI = newI./timesSampled;
newI = cast(newI, 'uint8');
end

function[newI] = amp(I, times)
[r, c] = size(I);

newI = zeros(r * times, c * times);

[nr, nc] = size(newI);

for x = 1:(nr)
    for y = 1:(nc)
        ix = ceil(x/times);
        iy = ceil(y/times);
        newI(x, y) = I(ix, iy);
    end
end
end
