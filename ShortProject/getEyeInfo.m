function [ E ] = getEyeInfo(path)

ime = dir(strcat(path, '*.eye'));
E = [];
n = length(ime);
for index = 1 : n
    eye_name = ime(index).name;
    
    data = importdata(strcat(path, eye_name),'');
    data_mat = cell2mat(cellfun(@str2num, data(2), 'UniformOutput', 0));
    
    ce1 = data_mat(1:2);
    ce2 = data_mat(3:4);
    
    ce = cat(2, ce1, ce2);
    E = cat(1, E, ce);
end
end