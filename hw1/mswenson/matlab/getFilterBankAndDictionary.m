function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

filterBank  = createFilterBank();
alpha =400
K = 175
%imPaths= strcat('../data/', imPaths);
filterResponses = [];
for i = 1:length(imPaths)
   disp(imPaths{i})
   img=imread(imPaths{i}); 
   samplePoints=randperm(numel(img)/3,alpha);
   [sX,sY]=ind2sub(size(img(:,:,1)),samplePoints);
   imgResp=extractFilterResponses(img, filterBank); 
   [x y z]=size(imgResp);
   for k =1:z
       for j=1:numel(sX)
           respSamples(j,k)=imgResp(sX(j),sY(j),k);
       end
   end
   filterResponses = cat(1,filterResponses, respSamples);
end

[~, dictionary] = kmeans(filterResponses, K, 'EmptyAction','drop');
dictionary=dictionary';
end
