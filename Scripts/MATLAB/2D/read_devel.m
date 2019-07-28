%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This script extracts and processes the solution from pFIRE@devel. The
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

cd(strcat(dir_res,'/pFIRE@devel'))
pfiredev.name = 'pfire@devel';

pfiredev.N=importdata('nodes.txt');
pfiredev.N=pfiredev.N.data(:,2:4);
Npdev=size(pfiredev.N,1);

pfiredev.U=importdata('disp.txt');
pfiredev.U=reshape(pfiredev.U.data,3,Npdev)';


cd(init)


