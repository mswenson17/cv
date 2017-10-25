function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

ra = imref2d(size(image1));
M = LucasKanadeAffine(image1, image2);
tform = affine2d(M);
i1w = imwarp(image1, tform, 'OutputView', ra, 'FillValues',128);

%i1w = imwarp(image1, tform);


mask = image2-i1w;

%image1=double(image1);
%[X, Y]= meshgrid(1:size(image1,2), 1:size(image1,1));
%points = [X(:) Y(:)]; points(:,3) = 1;
%Iw = M*points';
%Iw = Iw';
%wX = reshape(Iw(:,1),size(image1,1), size(image1,2));
%wY = reshape(Iw(:,2),size(image1,1), size(image1,2));
%Iw  = interp2(image1, wX, wY); 

%mask=uint8(double(image2)-Iw);

%SEe = offsetstrel('ball',3,9);
%SEd = strel('disk',4);
%figure(5)
%imshow(imbinarize(mask,.2));
%figure(1)
%imshow(imdilate(imbinarize(mask,.2),SEd));

%mask = imdilate(imbinarize(mask,.2),SEd);
mask = imbinarize(mask,.051);


