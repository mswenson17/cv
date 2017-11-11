close all;
clear all;

load ../data/carseq.mat
rect = [60 117 146 152];
montages(:,:,1,1) = frames(:,:,1);

rect1=rect
rect1s=rect;
rects=rect;

wrcts = rect;

T1 = frames(rect(2):rect(4),rect(1):rect(3),1);
T1 = double(T1);

for i = 2:size(frames,3)
    im1 = frames(:,:,i-1);
    im2 = frames(:,:,i);

    [dp_x dp_y] = LucasKanadeDriftless(im2,im1,rect,T1);
    [dp_x1 dp_y1] = LucasKanade(im1,im2,rect1);
    %warps(i,:) = [dp_x, dp_y];
    rect1(1)=rect1(1)+dp_x1;
    rect1(3)=rect1(3)+dp_x1;
    rect1(2)=rect1(2)+dp_y1;
    rect1(4)=rect1(4)+dp_y1;


    rect(1)=rect(1)+dp_x;
    rect(3)=rect(3)+dp_x;
    rect(2)=rect(2)+dp_y;
    rect(4)=rect(4)+dp_y;

    wrcts(i,:) = rect;


    if mod(i,100)==0
        frame=i
        montages(:,:,1,end+1) = frames(:,:,i);
        rects(end+1,:) = rect;
        rect1s(end+1,:) = rect1;
    end
end

save('carseqrects-wcrt.mat','wrcts');
montage(montages, 'Size',[1 NaN])
hold on
y=0;
for i= 1:size(rects,1)
    i
    rect = rects(i,:)
    rect1 = rect1s(i,:)
    plot(320*(i-1)+[rect(1) rect(1)],240*y+[rect(2) rect(4)],'y')
    plot(320*(i-1)+[rect(3) rect(3)],240*y+[rect(2) rect(4)],'y')
    plot(320*(i-1)+[rect(1) rect(3)],240*y+[rect(2) rect(2)],'y')
    plot(320*(i-1)+[rect(1) rect(3)],240*y+[rect(4) rect(4)],'y')

    plot(320*(i-1)+[rect1(1) rect1(1)],240*y+[rect1(2) rect1(4)],'g')
    plot(320*(i-1)+[rect1(3) rect1(3)],240*y+[rect1(2) rect1(4)],'g')
    plot(320*(i-1)+[rect1(1) rect1(3)],240*y+[rect1(2) rect1(2)],'g')
    plot(320*(i-1)+[rect1(1) rect1(3)],240*y+[rect1(4) rect1(4)],'g')
end

drawnow
im = frame2im(getframe(1));
imwrite(im, 'cartestcorrected.png');
