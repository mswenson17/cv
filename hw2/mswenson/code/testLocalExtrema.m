function extrema = testLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
    dog=DoGPyramid(:,:,1);

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
    %B= zeros(size(dog)); 
    %F= zeros(size(dog)); 

    %if(i>1) 
        %B = DoGPyramid(:,:,i-1); 
    %end

    %if(i<numel(DoGLevels))
        %F = DoGPyramid(:,:,i+1);
    %end

    maxima(:,:,1)  = dog>D;
    maxima(:,:,2)  = dog>U;
    maxima(:,:,3)  = dog>R;
    maxima(:,:,4)  = dog>L;
    maxima(:,:,5)  = dog>DR;
    maxima(:,:,6)  = dog>DL;
    maxima(:,:,7)  = dog>UR;
    maxima(:,:,8)  = dog>UL;
    %maxima(:,:,9)  = dog>B;
    %maxima(:,:,10) = dog>F;

    minima(:,:,1)  = dog<D;
    minima(:,:,2)  = dog<U;
    minima(:,:,3)  = dog<R;
    minima(:,:,4)  = dog<L;
    minima(:,:,5)  = dog<DR;
    minima(:,:,6)  = dog<DL;
    minima(:,:,7)  = dog<UR;
    minima(:,:,8)  = dog<UL;
    %minima(:,:,9)  = dog<B;
    %minima(:,:,10) = dog<F;
    
    extrema(:,:,1) = sum(maxima, 3);
    %extrema(:,:,2) = sum(minima, 3);

    extrema = extrema==8;
    extrema=sum(extrema,3);


end
