% your code here
close all;
clear all;
load ../data/carseq.mat

rect = [60 117 146 152];
montages(:,:,1,1) = frames(:,:,1);
rects=rect
carrects =rect

for i = 2:size(frames,3)
    %frame=i
    im1 = frames(:,:,i-1);
    im2 = frames(:,:,i);
    [dp_x dp_y] = LucasKanade(im1,im2,rect);

    rect(1)=rect(1)+dp_x;
    rect(3)=rect(3)+dp_x;
    rect(2)=rect(2)+dp_y;
    rect(4)=rect(4)+dp_y;

    carrects(i,:) = rect;
    if mod(i,100)==0
        montages(:,:,1,end+1) = frames(:,:,i);
        rects(end+1,:) = rect;
    end
end

save('carseqrects.mat','carrects');
montage(montages, 'Size',[1 NaN])
hold on
y=0;
for i= 1:size(rects,1)
    i
    rect = rects(i,:)
    plot(320*(i-1)+[rect(1) rect(1)],240*y+[rect(2) rect(4)],'y')
    plot(320*(i-1)+[rect(3) rect(3)],240*y+[rect(2) rect(4)],'y')
    plot(320*(i-1)+[rect(1) rect(3)],240*y+[rect(2) rect(2)],'y')
    plot(320*(i-1)+[rect(1) rect(3)],240*y+[rect(4) rect(4)],'y')
end

im = frame2im(getframe(1));
imwrite(im, 'cartest.png');
