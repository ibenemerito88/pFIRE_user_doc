%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This script extracts and processes the solution from pFIRE@0.4.0. The
solution is written to the structure variable
pfire040
which contains the field

name     String 
N        2D matrix with the coordinates of the nodes
U        2D matrix with the displacement of the nodes
E        2D matrix containing the nodes which form the tetrahedral elements
reg      Matrix of size depending on the registered image
Map      Structure, containing the results before they are printed to .txt
%}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(strcat('../../../Dataset/',sol,'/Results/pFIRE@devel'))
pfiredev.name = 'pfire@dev';

pfiredev.N=importdata('nodes.txt');
pfiredev.N=pfiredev.N.data(:,2:4);
Npdev=size(pfiredev.N,1);

pfiredev.E=importdata('elements.txt');
pfiredev.E=pfiredev.E.data;

pfiredev.U=importdata('disp.txt');
pfiredev.U=reshape(pfiredev.U.data,3,Npdev)';
pfiredev.U(:,[1 3])=pfiredev.U(:,[3 1]);

cd(init)



