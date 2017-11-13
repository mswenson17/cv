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


for i=1:size(p1,1)
A(1,:) = C1(3,:)*p1(i,1)-C1(1,:);
A(2,:) = C1(3,:)*p1(i,2)-C1(2,:);
A(3,:) = C2(3,:)*p2(i,1)-C2(1,:);
A(4,:) = C2(3,:)*p2(i,2)-C2(2,:);

%if(1==i)
    %A
%end

[U,D,V] = svd(A);
Ph(i,:) = V(:,4);
end
Ph = Ph./Ph(:,4);
P = Ph(:,1:3);
Ph(:,4)=1;

p1p = C1*Ph';
p2p = C2*Ph';

p1p = p1p(1:2,:)./p1p(3,:);
p2p = p2p(1:2,:)./p2p(3,:);

%p1p(:,1:10)'
%p1(1:10,:)

err1 = sum(sum((p1-p1p').^2,2));
err2 = sum(sum((p2-p2p').^2,2));
%all P(:,3)>0
err = err1+err2

end
