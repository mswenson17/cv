function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R th_contrast - remove any point that is a local extremum but does not have a DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal curvature ratio 
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.

locsDoG=[];

for i=1:numel(DoGLevels)
    dog=DoGPyramid(:,:,i);

    D = circshift(dog,1,1);
    D(1,:) = D(2,:);
    U = circshift(dog,-1,1);
    U(end,:) = U(end-1,:);
    R = circshift(dog,1,2);
    R(:,1) = R(:,2) ;
    L = circshift(dog,-1,2);
    L(:,end) = L(:,end-1);
    DR = circshift(D,1,2);
    DR(:,1) = DR(:,2) ;
    DL = circshift(D,-1,2);
    DL(:,end) = DL(:,end-1);
    UR = circshift(U,1,2);
    UR(:,1) = UR(:,2) ;
    UL = circshift(U,-1,2);
    UL(:,end) = UL(:,end-1);
    B= 256*ones(size(dog)); 
    F= 256*ones(size(dog)); 

    if(i>1) 
        B = DoGPyramid(:,:,i-1); 
    end

    if(i<numel(DoGLevels))
        F = DoGPyramid(:,:,i+1);
    end 
    maxima(:,:,1)  = dog>D;
    maxima(:,:,2)  = dog>U;
    maxima(:,:,3)  = dog>R;
    maxima(:,:,4)  = dog>L;
    maxima(:,:,5)  = dog>DR;
    maxima(:,:,6)  = dog>DL;
    maxima(:,:,7)  = dog>UR;
    maxima(:,:,8)  = dog>UL;
    maxima(:,:,9)  = dog>B;
    maxima(:,:,10) = dog>F;

    minima(:,:,1)  = dog<D;
    minima(:,:,2)  = dog<U;
    minima(:,:,3)  = dog<R;
    minima(:,:,4)  = dog<L;
    minima(:,:,5)  = dog<DR;
    minima(:,:,6)  = dog<DL;
    minima(:,:,7)  = dog<UR;
    minima(:,:,8)  = dog<UL;
    minima(:,:,9)  = dog<B;
    minima(:,:,10) = dog<F;
    
    extrema(:,:,1) = sum(maxima, 3);
    extrema(:,:,2) = sum(minima, 3);

    extrema = extrema==10;
    extrema=sum(extrema,3);

    %praying to god the two sets are mutually exclusive
    assert(max(max(extrema))==1);
    [x y] = find(extrema);
    [x_c y_c] = find(abs(dog)>th_contrast);
    [x_rp y_rp] = find(PrincipalCurvature(:,:,i)<th_r);
    [x_rn y_rn] = find(PrincipalCurvature(:,:,i)>0);

    points = intersect([x y], [x_c y_c], 'rows');
    points=intersect(points, [x_rp y_rp],'rows');
    points=intersect(points, [x_rn y_rn],'rows'); 

    points = circshift(points, 1, 2);
    points(:,3)=i;
    locsDoG = cat(1, locsDoG, points);
    
    %figure(i)
    %imshow(DoGPyramid(:,:,i),[])
    %hold on
    %plot(points(:,1),points(:,2),'o');
end 
%figure(6)
%imshow(DoGPyramid(:,:,1),[])
%hold on
%plot(locsDoG(:,1),locsDoG(:,2),'o');
%hold off

