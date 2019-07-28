%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This script extracts and processes the solution from pFIRE@0.4.0. The
solution is written to the structure variable
pfire040
which contains the field

name     String 
N        2D matrix with the coordinates of the nodes
U        2D matrix with the displacement of the nodes
reg      Matrix of size depending on the registered image
Map      Structure, containing the results before they are printed to .txt
%}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(strcat(dir_res,'/pFIRE@0.4.0'))
pfire040.name = 'pfire@0.4.0';

pfire040.N=importdata('nodes.txt');
pfire040.N=pfire040.N.data(:,2:4);
Np040=size(pfire040.N,1);

pfire040.U=importdata('disp.txt');
pfire040.U=reshape(pfire040.U.data,3,Np040)';

cd(init)


