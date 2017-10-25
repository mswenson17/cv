function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid

for i = 1:size(DoGPyramid, 3)
    [Dx Dy] = gradient(DoGPyramid(:,:,i));
    [Dxx Dxy] = gradient(Dx);
    [Dyx Dyy] = gradient(Dy);

    Tr = Dxx + Dyy;
    Det = Dxx.*Dyy-Dxy.*Dyx;

    PrincipalCurvature(:,:,i) = (Tr.^2)./Det;
    %aboveZero = PrincipalCurvature(:,:,i)>0;
    %PrincipalCurvature(:,:,i) = PrincipalCurvature(:,:,i).*aboveZero;


    %assert(size(DoGPyramid) == size(PrincipalCurvature))
end
