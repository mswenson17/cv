function panorama = generatePanorama(im1, im2)

[locs1 desc1] = briefLite(im1);
[locs2 desc2] = briefLite(im2);

[matches] = briefMatch(desc1, desc2);

H=ransacH(matches, locs1, locs2, 10000, 1.5);

panorama = imageStitching_noClip(im1,im2,H);

end
