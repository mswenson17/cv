function [histogram] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3}
%   (l1-normalized, ie. sum(h(:)) == 1)
    
tic
    L = layerNum -1;
    cellFrac=2^(L);
    [X Y]= size(wordMap);
    cW=floor(X/cellFrac);
    cH=floor(Y/cellFrac);
    w = ones(cellFrac-1,1)*cW;
    h = ones(cellFrac-1,1)*cH;
    w(end+1)=X-(cellFrac-1)*cW;
    h(end+1)=Y-(cellFrac-1)*cH;

    t=tabulate(reshape(wordMap, [],1));
    numValues = sum(t(:,2));

    cells = mat2cell(wordMap,w,h);
    getIF=@(wM) getImageFeatures(wM, dictionarySize);
    hist = cellfun(getIF, cells, 'UniformOutput',0);

    L2 = cat(2,hist{:,:});
    L2 = L2/(2)/numValues;
    L11 = hist{1,1}+hist{2,1}+hist{2,1}+hist{2,2};
    L13 = hist{3,1}+hist{4,1}+hist{3,1}+hist{4,2};
    L31 = hist{1,3}+hist{1,4}+hist{2,3}+hist{2,4};
    L33 = hist{3,3}+hist{4,3}+hist{3,4}+hist{4,4};
    L1 = cat(2,L11,L13,L31,L33)/4/numValues;
    L0 = (L11+L13+L31+L33)/4/numValues;

    histogram = cat(2,L2,L1,L0);
    histogram = reshape(histogram, [],1);
    %sum(histogram)
    %histogram = histogram/sum(histogram);
    toc
end
