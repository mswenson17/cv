function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
greenssdx=zeros(1,61)';   
bluessdx=zeros(1,61)';   
greenssd=zeros(1,61)';   
bluessd=zeros(1,61)';   
for i = -30:30
    greenshift = circshift(green, i);
    blueshift = circshift(blue, i);

    greenssd( i + 31) = ncc(red, greenshift);
    bluessd( i + 31) = ncc(red, blueshift);

end
[M,gind]=max(greenssd)
[M,bind]=max(bluessd)
green = circshift(green, gind -31);
blue = circshift(blue, bind -31);
for i = -30:30
    greenshift = circshift(green, i,2);
    blueshift = circshift(blue, i,2);

    greenssdx( i + 31) = ncc(red, greenshift);
    bluessdx( i + 31) = ncc(red, blueshift);

end
[M,gind]=max(greenssdx)
[M,bind]=max(bluessdx)
rgbResult = cat(3,red,circshift(green,gind-31,2 ),circshift(blue,bind-31,2 ));
end

function [output] = ssd(u, v)
    columns = sum((u-v).^2);
    output = mean(columns);
end

function [output] = ncc(u, v)
u=single(u);
v=single(v);
    normu = rssq(u);
    normv = rssq(v);
    output = mean(dot(u./normu,v./normv));
end
