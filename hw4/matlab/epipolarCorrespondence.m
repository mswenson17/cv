function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup

l = epipolarLine(F,[x1 y1]);
im1 = rgb2gray(im1);
im2 = rgb2gray(im2);
points = lineToBorderPoints(l,size(im2))
delta = points(:,1:2) - points(:,3:4)
step = floor(sqrt(sum(delta.^2,2)))

for i = 1:numel(delta)
points(:,i) = [round(linspace(points(1),points(3), step(i)));
          round(linspace(points(2),points(4), step(i)))];

dist = sqrt(sum((points - [x1;y1]).^2));
[~,ind] =min(dist);

window = 10;
patch = im1(max(1,y1-window):min(size(im1,1),y1),...
            max(1,x1-window):min(size(im1,2),x1));
best_ind = ind;
best_err = 1E10;

for i = max(window, ind-window):min(size(points,2),ind+window)
   if points(:,i)< size(im2) %&& points(:,i)>[0 0]
        y = points(1,i);
        x = points(2,i);
        patch2 = im2(max(1,y-window):min(size(im2,1),y),...
                     max(1,x-window):min(size(im2,2),x));
        err = sum(sum(abs(patch-patch2)));
        if err < best_err
            best_err = err;
            best_ind = ind;
        end
   end
end

p2 = points(:,best_ind)
x2 = points(1,best_ind);
y2 = points(2,best_ind);
