function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.  INPUTS: im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A

[X,Y] = size(im)
out_size
A
    for y = 1:Y-1
for x  = 1:X-1
        p_trans=[x;y;1];
        sample = round((A)*p_trans)
        sample = sample(1:2)./size(im)'

        if sample(1)<X && sample(1)>0 && sample(2)<Y && sample(2)>0
            warp_im(x,y)=im(sample(1),sample(2));
        else 
            warp_im(x,y)=0;
        end
    end
end 
