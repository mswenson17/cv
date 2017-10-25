function [dp_x,dp_y] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [dp_x,dp_y] in the x- and y-directions.


W = [0;0];
deltaP = [1;1];
It = double(It);
It1 = double(It1);
rect = floor(rect); 

[Tx Ty] = meshgrid(rect(1):rect(3), rect(2):rect(4));

T = interp2(It, Tx, Ty); 

[dx, dy] = gradient(It1);

bases_vector = squeeze(reshape(bases, [],1,10));
B = eye(size(bases_vector,1)) - bases_vector*bases_vector';

while norm(deltaP)>.001
    [Xq Yq] = meshgrid(rect(1)+W(1):rect(3)+W(1),...
                       rect(2)+W(2):rect(4)+W(2));
    wdx = interp2(dx,Xq,Yq);
    wdy = interp2(dy,Xq,Yq);

    It1shift = interp2(It1,Xq,Yq);
    errI = T-It1shift;

    grads = [wdx(:) wdy(:)];

    A = B*grads;
    %size(grads)
    %size(B)
    %size(A)

    err = B*errI(:);
    %size(err)

    deltaP = A\err;
    W = W+deltaP;
end

dp_x = W(1);
dp_y = W(2);

