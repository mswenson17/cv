function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation

H = [];
A = [];
for i = 1:numel(p1)/2
    N2 = pointmap(p2(:,i),p1(:,i));
    A=cat(1,A,N2);
end

[V D] = eig(A'*A);
[~,ind] = min(diag(D));
x=V(:,ind);
H2to1 = reshape(x, [3 3])';

end

function [N2] = pointmap(p, q)
x=p(1);
y=p(2);
u=q(1);
v=q(2);

    %A1(2*i - 1, :) = [p2t 0 0 0 -u*p2t];
n1 = [x y 1 0 0 0 -x*u -y*u -u];
n2 = [0 0 0 x y 1 -x*v -y*v -v];
N2 = [n1;n2];
end
