%% Check the dimensions of function arguments
%%  This is *not* a correctness check
function checkA4Format()
    addpath('matlab');
    load('data/some_corresp.mat', 'pts1', 'pts2');
    load('data/intrinsics.mat', 'K1', 'K2');
    im1 = imread('data/im1.png');
    im2 = imread('data/im2.png');
    
    N = size(pts1, 1);
    M = 100; % place holder
    
    % 2.1
    F8 = eightpoint(pts1, pts2, M);
    assert(isequal(size(F8), [3, 3]), 'eightpoint returns 3x3 matrix');
    
    % 2.2
    F7 = sevenpoint(pts1(1:7, :), pts2(1:7, :), M);
    assert(numel(F7) == 1 || numel(F7) == 3, ...
           'sevenpoint returns length-1/3 cell');
    
    for i = 1 : numel(F7)
        assert(isequal(size(F7{i}), [3, 3]), ...
               'seven returns cell of 3x3 matrix');
    end
    
    % 3.1
    C1 = [eye(3), zeros(3, 1)];
    C2 = [eye(3), ones(3, 1)];
    
    [P, err] = triangulate(C1, pts1, C2, pts2);
    assert(isequal(size(P), [N, 3]), 'triangulate returns Nx3 matrix P');
    assert(numel(err) == 1, 'triangulate returns scalar err');
        
    % 4.1
    [x2, y2] = epipolarCorrespondence(im1, im2, F8, pts1(1, 1), pts1(1, 2));
    assert(numel(x2) == 1 && numel(y2) == 1, ...
           'epipolarCoorespondence returns x & y coordinates');

    fprintf('Format check passed.\n');
end
