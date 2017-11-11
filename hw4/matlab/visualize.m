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
F = refineF(F,pts1,pts2)

[ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1)


%E = essentialMatrix(F, K1, K2);
%M2s = camera2(E);

%M1 = eye(3); M1(:,4) = 0;

%%normalize points
%pts1=pts1/M;
%pts2=pts2/M;

%best_err = 10E10;
%P=[];
%C2=[];
%for i = 1:size(M2s,3)
%[testP, err] = triangulate(K1*M1, pts1, K2*M2s(:,:,i), pts2);
    %if err<best_err
        %best_err = err;
        %M2 = M2s(:,:,i);
        %C2 = K2*M2;
        %P = testP;
    %end
%end
%pts1=pts1*M;
%pts2=pts2*M;

