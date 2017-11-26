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
points = lineToBorderPoints(l,size(im2));
delta = points(1:2) - points(3:4);
step = floor(sqrt(sum(delta.^2)));


points = [floor(linspace(points(2),points(4), step));
          floor(linspace(points(1),points(3), step))];

window = 10;
x1 = round(x1);
y1 = round(y1);

patch = imgaussfilt(im1(y1-window:y1+window,...
                        x1-window:x1+window));
ind = y1;
best_err = 1E10;

for i = max(window, ind-window*2):min(size(points,2),ind+window*2)
   if points(:,i)+window<size(im2)'
       if points(:,i)-window> 0
        y = points(1,i);
        x = points(2,i);
        patch2 = imgaussfilt(im2(y-window:y+window,...
                                 x-window:x+window));

        err = ssd(patch,patch2);

        if err < best_err
            best_err = err;
            ind = i;
        end
    end
   end
end


p2 = points(:,ind);
x2 = points(2,ind);
y2 = points(1,ind);
end

function [output] = ssd(u, v)
    columns = sum((u-v).^2);
    output = sum(columns);
end
