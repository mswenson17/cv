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
   for i=1:y
       row = squeeze(imgResp(:,i,:));
       wordComp=pdist2(dictionary', row);
       [a wordInd] = min(wordComp);
       wordMap = cat(1,wordMap, wordInd);
   end

   wordMap=wordMap';
   %knnsearch(dictionary',pixel', 'Distance', 'euclidean')
   %imagesc(wordMap)
end
