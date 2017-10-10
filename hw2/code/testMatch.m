function matches = testMatch()

    im1 = imread('../data/pf_scan_scaled.jpg');
    im1(:,:,2)=im1(:,:,1);
    im1(:,:,3)=im1(:,:,1);
    %im2 = imread('../data/pf_desk.jpg');
    %im2 = imread('../data/pf_floor.jpg');
    %im2 = imread('../data/pf_floor_rot.jpg');
    %im2 = imread('../data/pf_pile.jpg');
    %im2 = imread('../data/pf_stand.jpg');

    im1 = imread('../data/model_chickenbroth.jpg');
    im2 = imread('../data/chickenbroth_01.jpg');

    %im1 = imread('../data/incline_L.png');
    %im2 = imread('../data/incline_R.png');

    [locs1 desc1] = briefLite(im1);
    [locs2 desc2] = briefLite(im2);

    [matches] = briefMatch(desc1, desc2);

    plotMatches(im1,im2, matches, locs1, locs2);

end
