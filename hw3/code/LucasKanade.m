function [dp_x,dp_y] = LucasKanade(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y] in the x- and y-directions.

W = [0;0];
deltaP = [1;1];
It = double(It);
It1 = double(It1);
rect = floor(rect);

[Tx Ty] = meshgrid(rect(1):rect(3), rect(2):rect(4));

T = interp2(It, Tx, Ty); 

[dx, dy] = gradient(It1);

while norm(deltaP)>.001
        [Xq Yq] = meshgrid(rect(1)+W(1):rect(3)+W(1),...
                           rect(2)+W(2):rect(4)+W(2));
        wdx = interp2(dx,Xq,Yq);
        wdy = interp2(dy,Xq,Yq);

        It1shift = interp2(It1,Xq,Yq);
        errI = T-It1shift;

        grads = [wdx(:) wdy(:)];

        A = grads'*grads;

        err = grads'*errI(:);

        deltaP = A\err;
        W = W+deltaP;
end

%while norm(deltaP)>.001
    %H=zeros(2);
    %sumerr=0;
    %[Xq Yq] = meshgrid(rect(1)+W(1):rect(3)+W(1),...
                       %rect(2)+W(2):rect(4)+W(2));
    %wdx = interp2(dx,Xq,Yq);
    %wdy = interp2(dy,Xq,Yq);
    %It1shift = interp2(It1,Xq,Yq);

    %for x = 1:size(It1shift,2)
        %for y = 1:size(It1shift,1)
            %grad(1) = wdx(y,x);
            %grad(2) = wdy(y,x);

            %H  = H + grad'*grad;
            %errI = T(y,x)-It1shift(y,x);

            %sumerr=sumerr+grad'*errI;
        %end
    %end

    %deltaP = H\sumerr;
    %W = W+deltaP;
%end

dp_x = W(1);
dp_y = W(2);

