function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

   imgResp=extractFilterResponses(img, filterBank); 
   [x y z]= size(imgResp); 
   wordMap=[];
   imgResp = squeeze(reshape(imgResp, [], 1,60));
   wordComp=pdist2(dictionary', imgResp);
   [a wordInd] = min(wordComp);
   wordMap = reshape(wordInd, x,y);
end
