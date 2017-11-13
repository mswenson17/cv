% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3

load ../data/templeCoords.mat
load ../data/intrinsics.mat
load ../data/some_corresp.mat

im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

M = max(size(im1));
F = eightpoint(pts1,pts2,M);

x2 = []; y2 = [];
for i = 1:numel(x1)
[x2(i), y2(i)] = epipolarCorrespondence( im1, im2, F, x1(i), y1(i));
end

E = essentialMatrix(F, K1, K2);
M2s = camera2(E);

M1 = eye(3); M1(:,4) = 0;

p1 = [x1 y1];
p2 = [x2' y2'];
size(pts1)
size(pts2)

%normalize points
best_err = 10E10;

for i = 1:1
[P, err] = triangulate(K1*M1, p1, K2*M2s(:,:,i), p2);
    if all(testP(:,3)>0)
        if err<best_err 
            best_err = err;
            M2 = M2s(:,:,i);
            C2 = K2*M2;
            P = testP;
        end
    end
end
figure(2)
scatter3(P(:,1),P(:,2),P(:,3))


