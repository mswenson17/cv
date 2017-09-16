function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


img=double(img);
filterResponses=[]; 
[L,a,b] = RGB2Lab(img(:,:,1),img(:,:,2),img(:,:,3));
labimg = cat(3, L,a,b);
for i = 1:20
    filterResponses = cat(3,filterResponses, lab2rgb(imfilter(labimg, filterBank{ i })));
end
%imshow(filterResponses(:,:,7:9));
%montage(filterResponses,  'Size', [4 5]);
end
