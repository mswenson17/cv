function [dp_x,dp_y] = LucasKanadeDriftless(It, It1, rect, T1)
% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y] in the x- and y-directions.

% warp is 
W = [0;0];
deltaP = [1;1];
It = double(It);
It1 = double(It1);
rect = floor(rect);

[Tx Ty] = meshgrid(rect(1):rect(3), rect(2):rect(4));

T = interp2(It, Tx, Ty); 

[dx, dy] = gradient(It1);

[W(1) W(2)] = LucasKanade(It, It1, rect);

deltaP =[1 1];
while norm(deltaP)>.001
    H=zeros(2);
    sumerr=0;
    [Xq Yq] = meshgrid(rect(1)+W(1):rect(3)+W(1),...
                       rect(2)+W(2):rect(4)+W(2));
    wdx = interp2(dx,Xq,Yq);
    wdy = interp2(dy,Xq,Yq);
    It1shift = interp2(It1,Xq,Yq);

    for x = 1:size(It1shift,2)
        for y = 1:size(It1shift,1)
            grad(1) = wdx(y,x); %wdx(:,1)
            grad(2) = wdy(y,x); %wdx1(:,1)

            H  = H + grad'*grad;
            errI = T1(y,x)-It1shift(y,x);

            sumerr=sumerr+grad'*errI;
        end
    end

    deltaP = H\sumerr;
    W = W+deltaP;
    %norm(deltaP)
end
%Ps
%Ws
dp_x = W(1);
dp_y = W(2);

