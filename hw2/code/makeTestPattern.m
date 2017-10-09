function [compareA, compareB] = makeTestPattern(patchWidth, nbits) 
%%Creates Test Pattern for BRIEF 
% Run this routine for the given parameters patchWidth = 9 and n = 256 and save the results in testPattern.mat.  
% INPUTS
% patchWidth - the width of the image patch (usually 9)
% nbits      - the number of tests n in the BRIEF descriptor
%
% OUTPUTS
% compareA and compareB - LINEAR indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors. 

Ax=randn(nbits,1);
Ay=randn(nbits,1);
Bx=randn(nbits,1);
By=randn(nbits,1);
%Bx=randn(patchWidth);
%By=randn(patchWidth);
Aminx = min(min(Ax));
Aminy = min(min(Ay));
Arange_x = max(max(Ax))-Aminx; Arange_y = max(max(Ay))-Aminy;
Bminx = min(min(Bx));
Bminy = min(min(By));
Brange_x = max(max(Bx))-Bminx;
Brange_y = max(max(By))-Bminy;

Ax = round((patchWidth-1)*(Ax-Aminx)./Arange_x)+1;
Ay = round((patchWidth-1)*(Ay-Aminy)./Arange_y)+1;
Bx = round((patchWidth-1)*(Bx-Bminx)./Brange_x)+1;
By = round((patchWidth-1)*(By-Bminy)./Brange_y)+1;

compareA= sub2ind([patchWidth patchWidth], (Ax), (Ay));
compareB= sub2ind([patchWidth patchWidth], (Bx), (By));

compareA=randi(patchWidth^2, nbits, 1);
compareB=randi(patchWidth^2, nbits, 1);
compareX = compareA;
compareY = compareB;


save testPattern.mat compareA compareB compareX compareY

figure 
hold off
hold on
[Ax Ay] = ind2sub([patchWidth patchWidth], compareA);
[Bx By] = ind2sub([patchWidth patchWidth], compareB);
for i = 1:nbits
plot([Ax(i) Bx(i)], [Ay(i) By(i)]); 
end
end
