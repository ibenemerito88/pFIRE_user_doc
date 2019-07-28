%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
This function masks the results extracted from the .txt files to extract
the solution in a smaller region. It takes as input the solution contained
in the structure "method" and a 3D vector "v" which containes the desired
percentage of shrinkage 

v = [px py pz]
px is a number between 0 and 1. If px==.7 than the domain is shrinked by
70% in the x direction, slicing 15% from each side. Same applies for py and
pz.

method_masked = apply_mask(method,v)



%}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function method_masked = apply_mask(method,v)