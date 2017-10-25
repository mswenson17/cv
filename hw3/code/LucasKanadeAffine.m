function M = LucasKanadeAffine(It, It1)
% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y] in the x- and y-directions.

% warp is 
W = eye(3);
deltaP = [1 0 0 0 1 0];
P =      [0 0 0 0 0 0];
It = double(It);
It1 = double(It1);

[X, Y]= meshgrid(1:size(It,2), 1:size(It,1));
points = [X(:) Y(:)]; points(:,3) = 1;
[dx, dy] = gradient(It1);



i =0;
while norm(deltaP)>.001 && i<20
i=i+1;

Iw = W*points';
Iw = Iw';

wX = reshape(Iw(:,1),size(It,1), size(It,2));
wY = reshape(Iw(:,2),size(It,1), size(It,2));

Iw  = interp2(It1, wX, wY); 
wdx = interp2(dx,wX,wY);
wdy = interp2(dy,wX,wY);

Iw=Iw(:);
wdx=wdx(:);
wdy=wdy(:);

nanscrub = [X(:) Y(:) It(:) Iw(:) wdx(:) wdy(:)];
scrub = sum(isnan(nanscrub),2)>0;

%prescrub= size(nanscrub)
nanscrub(scrub,:)=[];
%postnanscrub = size(nanscrub)

vX   = nanscrub(:,1);
vY   = nanscrub(:,2);
vIt  = nanscrub(:,3);
vIw  = nanscrub(:,4);
vwdx = nanscrub(:,5);
vwdy = nanscrub(:,6);

%SD = [X(:).*wdx(:) Y(:).*wdx(:) wdx(:) X(:).*wdy(:) Y(:).*wdy(:) wdy(:)];
SD = [vX.*vwdx vY.*vwdx vwdx vX.*vwdy vY.*vwdy vwdy];

errI = vIt-vIw;

deltaP = SD\errI;

P = P+deltaP;

W = [1+P(1) P(2) P(3);...
     P(4) 1+P(5) P(6);...
     0 0 1];

end

M = W';


