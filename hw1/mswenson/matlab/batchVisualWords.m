function batchVisualWords(numCores) 

% Does parallel computation of the visual words 
%
% Input:
%   numCores - number of cores to use (default 2)


%load the files and texton dictionary
load('../data/traintest.mat','all_imagenames','mapping');
load('dictionary.mat','filterBank','dictionary');

source = '../data/';
target = '../data/'; 

if ~exist(target,'dir')
    mkdir(target);
end

for category = mapping
    if ~exist([target,category{1}],'dir')
        mkdir([target,category{1}]);
    end
end
%matlab can't save/load inside parfor; accumulate
%them and then do batch save
l = length(all_imagenames);

for i=1:l
    if ~exist([target, strrep(all_imagenames{i}, '.jpg','.mat')])
        fprintf('Converting to visual words %s\n', all_imagenames{i});
        image = imread([source, all_imagenames{i}]);
        wordMap= getVisualWords(image, filterBank, dictionary);
        save([target, strrep(all_imagenames{i},'.jpg','.mat')],'wordMap');
    end
end



end
