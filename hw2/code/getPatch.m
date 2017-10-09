function [S] = getPatch(im, poi, patchWidth, compareA, compareB)

    patchWidth=patchWidth-1;
    up = ceil(patchWidth/2);
    down = floor(patchWidth/2);

    patch = im(poi(1)-down:poi(1)+up, poi(2)-down:poi(2)+up);

    a = patch(compareA);
    b = patch(compareB);

    S = (a>b)';
end
