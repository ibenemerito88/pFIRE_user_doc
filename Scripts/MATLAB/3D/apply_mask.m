%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
This function masks the results extracted from the .txt files to extract
the solution in a smaller region. It takes as input the solution contained
in the structure "method" and a 3D vector "v" which containes the desired
percentage of shrinkage 

This set of scripts and function has been developed by 
Dr Ivan Benemerito, INSIGNO Institute for in silico medicine, Sheffield, UK
i.benemerito@sheffield.ac.uk

v = [px py pz]
px is a number between 0 and 1. If px==.7 than the domain is shrinked by
70% in the x direction, slicing 15% from each side. Same applies for py and
pz.

method_masked = apply_mask(method,v)



%}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function masked = apply_mask(method,v)

v = v+[.01 .01 .01];

% Compute centre 
c = mean(method.N);
% Compute length 
l = max(method.N)-min(method.N);
% Compute desired length
d = v.*l;
% Compute new boundary
e = [c-d/2; c+d/2];
% Select nodes to keep
minx = find(method.N(:,1)<=e(2,1));
maxx = find(method.N(:,1)>=e(1,1));
miny = find(method.N(:,2)<=e(2,2));
maxy = find(method.N(:,2)>=e(1,2));
minz = find(method.N(:,3)<=e(2,3));
maxz = find(method.N(:,3)>=e(1,3));
nodex = intersect(minx,maxx);
nodey = intersect(miny,maxy);
nodez = intersect(minz,maxz);
% Final result
nod = intersect(intersect(nodex,nodey),nodez);
masked.name = strcat(method.name,'_masked');
masked.N = method.N(nod,:);
masked.U = method.U(nod,:);



