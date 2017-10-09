% Script to test BRIEF under rotations
function  briefRotTest()

    im1 = imread('../data/model_chickenbroth.jpg');
    im2 = imread('../data/model_chickenbroth.jpg');

    [locs1 desc1] = briefLite(im1);
    numMatches=[];
    for i=0:35
        im2=imrotate(im1, i*10);

        [locs2 desc2] = briefLite(im2);

        [matches] = briefMatch(desc1, desc2);
        numMatches = cat(1, numMatches, [i numel(matches(:,1))]);
    end

    bar(10*numMatches(:,1), numMatches(:,2));

        %plotMatches(im1,im2, matches, locs1, locs2);
end
