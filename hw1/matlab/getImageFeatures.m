function [h] = getImageFeatures(wordMap, dictionarySize)
% Compute histogram of visual words
% Inputs:
% 	wordMap: WordMap matrix of size (h, w)
% 	dictionarySize: the number of visual words, dictionary size
% Output:
%   h: vector of histogram of visual words of size dictionarySize (l1-normalized, ie. sum(h(:)) == 1)

    t=tabulate(reshape(wordMap, [],1));
    h=zeros(dictionarySize, 1); 
    numValues = numel(t(:,1)); 
    h(1:numValues) = t(:,2);
    h=h/norm(h);

	assert(numel(h) == dictionarySize);
end
