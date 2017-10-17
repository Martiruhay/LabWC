function [out] = lab3_ex1(in)
% efficient median filter
% [1 2 current 4 5]
% current = avg[1 2 current 4 5]
out = in;
[r,c] = size(in);
for i = offset+1:(r-offset)
    for j = offset+1:(c-offset)
        val = in(i,j);
        % [1 2 3 4 5] / 5
        % 1 ([2 3 4 5 6] - 1) / 5
        
        
    end
end
end

