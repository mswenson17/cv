% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat

load ../data/intrinsics.mat
load ../data/some_corresp.mat
im1 = imread('../data/im1.png');
im2 = imread('../data/im2.png');

M = max(size(im1));
F = eightpoint(pts1,pts2,M);
F = refineF(F,pts1,pts2);

E = essentialMatrix(F, K1, K2);
M2s = camera2(E);

M1 = eye(3); M1(:,4) = 0;

%normalize points
pts1=pts1/M;
pts2=pts2/M;

best_err = 10E10;
P=[];
C2=[];
for i = 1:size(M2s,3)
[testP, err] = triangulate(K1*M1, pts1, K2*M2s(:,:,i), pts2);
    if err<best_err
        best_err = err;
        M2 = M2s(:,:,i);
        C2 = K2*M2;
        P = testP;
    end
end
pts1=pts1*M;
pts2=pts2*M;

save('q3_3.mat','M2','C2','pts1' ,'pts2','P'); 



