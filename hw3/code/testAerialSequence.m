% your code here

clear all
close all

load ../data/aerialseq.mat 

montages=[];
for i = 2:size(frames,3)
    i
    im1 = frames(:,:,i-1);
    im2 = frames(:,:,i);

    mask = SubtractDominantMotion(im1,im2);

    fused = imfuse(im2, mask);

    if mod(i,30)==0
        montages = cat(4,montages, fused);
    end

    %imshow(mask);
end

%size(montages)
    %figure
    %imshow(fused(:,:,:,1));
    %figure

m=montage(montages, 'Size',[1 NaN]);
im = frame2im(getframe(gca));
imwrite(im, 'aerialtest.png');
