function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup

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

[U, S, V] = svd(UV);
F1 = V(:,end-1);
F2 = V(:,end);

F1 = reshape(F1, [3 3]);
F2 = reshape(F2, [3 3]);
F1 = F1';
F2 = F2';
syms lambda

F = F2*(1-lambda)+lambda*F1;
eq = det(F)==0;

l=vpasolve(eq,lambda,[-Inf,Inf]);

F={};
for i=1:numel(l)
Fi = F2*(1-l(i))+l(i)*F1;
Fi = round(double(Fi),6);
Fi = refineF(Fi, Tpts1,Tpts2); 
Fi =  T'*Fi*T;
F{i} = Fi;
end


%save('q2_2.mat', 'F', 'M', 'pts1', 'pts2');
end

