function [locs,desc] = computeBrief2(im, GaussianPyramid, locsDoG, k,  ...
levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary


patchWidth = ceil(sqrt(max(compareA)));
patchWidth=patchWidth-1;
up = ceil(patchWidth/2);
down = floor(patchWidth/2);
[x y z] = size(im);
locs =[];
desc =[];


for i= 1:numel(locsDoG(:,1))
    if locsDoG(i,1)>5 & ...
        locsDoG(i,1)<y-5 &  ...
        locsDoG(i,2)>5 & ...
        locsDoG(i,2)<x-5 

        locs = cat(1,locs, locsDoG(i,:));

        poi = locs(end,:);
        gl = GaussianPyramid(:,:,poi(3));

        S= [];
        for j = 1:numel(compareA)

            [Ax Ay] = ind2sub([patchWidth,patchWidth], compareA(j));
            [Bx By] = ind2sub([patchWidth,patchWidth], compareB(j));

            %poi
            %cAx= Ax
            %size(gl)
            Ax = Ax+poi(1)-5;
            Ay = Ay+poi(2)-5;
            Bx = Bx+poi(1)-5;
            By = By+poi(2)-5;

            S(j) = gl(Ay,Ax) < gl(By,Bx);
        end
        desc(end+1,:) = S;
    end
end



