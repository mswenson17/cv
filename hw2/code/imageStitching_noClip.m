function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image

close all
save('../results/c6_1.mat', 'H2to1');
im1size = size(img1);
im2size = size(img2)

%wimsize = [2*im1size(1) im2size(2)+im2size(2), 3];
%wim = warpH(img2, H2to1, wimsize);
wim = warpH(img2, H2to1, im2size);

%sizediff = wimsize- size(img1);
imcomb = img1;
%imcomb(end:end+sizediff(1), end:end+sizediff(2),:)=0;
imcomb(end:end+im2size(1)/4, end:end+im2size(2)/4,:)=0;
size(img2)
size(wim)
size(imcomb)
%figure(1)
%imshow(imcomb)

%[locs1 desc1] = briefLite(img1);
%[locs2 desc2] = briefLite(wim);
%[matches] = briefMatch(desc1, desc2);
%save('stuff.mat', 'locs1', 'locs2', 'matches', 'desc1', 'desc2');

load stuff.mat
warning('off','images:initSize:adjustingMag');

p1 = locs1(matches(:,1),:);
p2 = locs2(matches(:,2),:); 
m=matches(1:10,:)
diff = p1(:,1:2)-p2(:,1:2);

size(diff)
for i = 1:size(diff,1)
    shift = diff(i,:);
    diffTemp =diff-shift;
    distance = realsqrt(sum(diffTemp.^2,2));
    avg_distance = mean(distance);
    if i==1
        offset=shift
        bestdistance=avg_distance
    elseif avg_distance < bestdistance
        offset=shift
        bestdistance=avg_distance
    end

end

%p110=p1(1:10,:)'
%p210=p2(1:10,:)'
%d10=diff(1:10,:)'

%offset = round(mean(diff,1))
%offset = diff(1,:);
offset(1)=offset(1)+1;
wim = circshift(wim, offset(2), 1);
wim = circshift(wim, offset(1), 2);
figure(2)
imshow(wim);

%imdiff = wim- imcomb;
addim=uint8(imcomb==0);
%figure(4)
%imshow(imdiff)
wim= wim.*addim;
imcomb = imcomb+wim;

figure(3)
imshow(imcomb)

%plotMatches(img1,wim, matches, locs1, locs2); 
