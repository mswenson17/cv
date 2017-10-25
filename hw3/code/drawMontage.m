
hold off;

size(montages)
figure(2)
montage(montages, 'Size',[NaN,size(montages,4)/2]);
rect = [60 117 146 152];
plot(100,200,'o');
for i=0:size(montages,4)-1
hold on
        [y x] = ind2sub([2,size(montages,4)/2],i);

        plot(320*x+[rect(1) rect(1)],240*y+[rect(2) rect(4)])
        plot(320*x+[rect(3) rect(3)],240*y+[rect(2) rect(4)])
        plot(320*x+[rect(1) rect(3)],240*y+[rect(2) rect(2)])
        plot(320*x+[rect(1) rect(3)],240*y+[rect(4) rect(4)])
end
