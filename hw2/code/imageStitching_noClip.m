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
im1size = size(img1);
im2size = size(img2);
%         top right        top left      botom right            bottom left
corners =[im2size(2), 1,1 ; 1, 1,1 ;im2size(2), im2size(1),1 ;1, im2size(1),1 ]';
warning('off','images:initSize:adjustingMag');

transcorners = H2to1*corners;
transcorners = transcorners(1:2,:)./transcorners(3,:)

%naspect =sqrt(sum(transcorners(1:2,2)-transcorners(1:2,3)).^2)
xsize = round(max(transcorners(1,:))-min(transcorners(1,:)));
ysize = round(max(transcorners(2,:))-min(transcorners(2,:)));

xoffset = min(transcorners(1,:));
yoffset = min(transcorners(2,:));

m = eye(3);
m(1,3) = -xoffset;
m(2,3) = -yoffset;

wimsize = [ysize,xsize, 3];

wim = warpH(img2, m*H2to1,wimsize);

[locs1 desc1] = briefLite(img1);
[locs2 desc2] = briefLite(wim);
[matches] = briefMatch(desc1, desc2);
%save('stuff.mat', 'locs1', 'locs2', 'matches', 'desc1', 'desc2');
%load stuff.mat

p1 = locs1(matches(:,1),:);
p2 = locs2(matches(:,2),:); 
diff = p1(:,1:2)-p2(:,1:2);

for i = 1:size(diff,1)
    shift = diff(i,:);
    diffTemp =diff-shift;
    distance = realsqrt(sum(diffTemp.^2,2));
    avg_distance = mean(distance);
    if i==1
        offset=shift;
        bestdistance=avg_distance;
    elseif avg_distance < bestdistance;
        offset=shift;
        bestdistance=avg_distance;
    end

end
offset

imcombsize=[max((im1size(1)+abs(offset(2))),wimsize(1)), max(wimsize(2),(im1size(2)+abs(offset(1)))),3];
imcomb= zeros(imcombsize);
buffer=zeros(wimsize(1), abs(offset(1)),3);
wim = cat(2,buffer , wim);

buffer = zeros(abs(offset(2)),im1size(2),3);
im1 =  cat(1,buffer, img1); 

wim(1:size(im1,1), 1:size(im1,2),:)=max(im1,wim(1:size(im1,1), 1:size(im1,2),:));
panoImg = wim;
%imshow(wim)
