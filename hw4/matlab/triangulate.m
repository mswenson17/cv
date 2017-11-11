function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q3.2:
%       Implement a triangulation algorithm to compute the 3d locations
%

%homogenize
p1(:,3) =1;
p2(:,3) =1;
%C1(4,:) = [0 0 0 1];
%C2(4,:) = [0 0 0 1];

zero = p1(:,1).*0;
% convert points to cross product as matrix form
p1x = [zero -p1(:,3) p1(:,2)...
       p1(:,3) zero -p1(:,1)...
       -p1(:,2) p1(:,1) zero];

p2x = [zero -p2(:,3) p2(:,2)...
       p2(:,3) zero -p2(:,1)...
       -p2(:,2) p2(:,1) zero];

p1x = reshape(p1x', 3,3,[]);
p1x = permute(p1x, [2 1 3]);
p2x = reshape(p2x', 3,3,[]);
p2x = permute(p2x, [2 1 3]);

for i=1:size(p1x,3)
pxM = cat(1, p1x(:,:,i)*C1, p2x(:,:,i)*C2);

[U,D,V] = svd(pxM);
x = V(:,end);
P (i,:) = x(1:3)/x(4);
end
Ph = P; Ph(:,4)=1;
%p1size=size(p1)
%phsize=size(Ph)
%c1size=size(C1)


p1p = C1*Ph';
p2p = C2*Ph';

p1p = (p1p(1:2,:)./p1p(3,:))';
p2p = (p2p(1:2,:)./p2p(3,:))';

p1 = p1(:,1:2);
p2 = p2(:,1:2);

dist = sqrt(sum((p1-p1p).^2,2));

err1 = sum(sqrt(sum((p1-p1p).^2,2)));
err2 = sum(sqrt(sum((p2-p2p).^2,2)));

err = err1+err2;

end
