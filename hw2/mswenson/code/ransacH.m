function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC

if exist('nIter', 'var') == 0
    nIter = 1000;
end 
if exist('tol', 'var') == 0
    tol = 4;
end 

numInliers=0;
locs1(:,3)=1;
locs2(:,3)=1;
%size(locs1)

for i = 1:nIter
hInliers = randi(numel(matches)/2, 4,1);

%size(matches)
%size(matches(:,1))
mp1=locs1(matches(:,1),:)';
mp2=locs2(matches(:,2),:)';

p1 = mp1(1:2, hInliers);
p2 = mp2(1:2, hInliers);

H = computeH(p1,p2);

hmp2 = H*(mp2);
%prescaled = hmp2(:,1:10)
hp2 = hmp2(1:2,:)./hmp2(3,:);
%scaled = hp2(:,1:10)

ssd = sum((hp2-mp1(1:2,:)).^2);
inliers = ssd<tol^2;
if  sum(inliers)>numInliers
    winningssd = ssd;
    bestH = H;
    bestInliers = inliers;
    numInliers = sum(inliers);
end

end
%mean(winningssd)
%numInliers


