function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup

T = [1/M 0      0;...
     0      1/M 0;...
     0      0      1];

Tpts1 = pts1/M;
Tpts2 = pts2/M;

u=  Tpts1(:,1);
v=  Tpts1(:,2);
up= Tpts2(:,1);
vp= Tpts2(:,2);

UV = [u.*up u.*vp u v.*up v.*vp v up vp];
UV(:,9) = 1;

%[V D] = eig(UV'*UV);
%[~,ind] = min(diag(D));
%x=V(:,ind)

[U, S, V] = svd(UV);
x = V(:,end);

F = reshape(x, [3 3]);

[U, W, V] = svd(F);
W(3,3)=0;

F=U*W*V';

F = refineF(F, Tpts1,Tpts2);

F =  T'*F*T;
end

