% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
load('../data/red.mat');
load('../data/green.mat');
load('../data/blue.mat');

size(red)

rgbInit = cat(3,red,green,blue);
figure, imshow(rgbInit);
rgbResult = alignChannels(red, green, blue);
figure, imshow(rgbResult);
%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
