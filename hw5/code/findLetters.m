function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.

warning('off', 'Images:initSize:adjustingMag');
%Your code here
im = imcomplement(imbinarize(rgb2gray(im)));
se = strel('disk',4);
im = imclose(im,se);
bw = imcomplement(im);

CC = bwconncomp(im);
stats = regionprops(CC,'Image','Area','Centroid','BoundingBox');

area=[];
image=[];
boxes=[]; 
for i = 1:numel(stats) 
    area(end+1,:) = stats(i).Area;
end

figure
imshow(imcomplement(im));
area_avg = sum(area)/numel(area);
for i = 1:numel(area)
    if area(i)>area_avg/3
        boxes(end+1,1:2) = stats(i).Centroid;
        boxes(end,3) = i;
        boxes(end,4:7) = stats(i).BoundingBox;
        image{end+1} = stats(i).Image;
    rectangle('Position',stats(i).BoundingBox, 'EdgeColor', 'r', 'Linewidth',1)
    end
end
pause(1);
boxes = sortrows(boxes,2);
bb = boxes(:,4:7);
centroid = boxes(:,1:2);
letter_height = sum(bb(:,4))/numel(stats);

currentline = 1;
currentletter = 1;
lastcentroid =  centroid(1,:);
lines={};
for i = 1:size(centroid,1)
    if abs(centroid(i,2)-lastcentroid(2))>letter_height*.75
        currentline = currentline+1;
        currentletter = 1;
    end
    lines{currentline}(currentletter,:) = [bb(i,1:2) bb(i,1)+bb(i,3) bb(i,2)+bb(i,4)];
    lastcentroid = centroid(i,:);
    currentletter = currentletter+1;
end

lines = cellfun(@(x)sortrows(x,1),lines, 'UniformOutput' , 0);

%figure(1)
%hold on;
%scatter(lines{1}(:,1),lines{1}(:,2))

assert(size(lines{1},2) == 4,'each matrix entry should have size Lx4');
assert(size(lines{end},2) == 4,'each matrix entry should have size Lx4');
lineSortcheck = lines{1};
assert(issorted(lineSortcheck(:,1)) | issorted(lineSortcheck(end:-1:1,1)),'Matrix should be sorted in x1');

end
