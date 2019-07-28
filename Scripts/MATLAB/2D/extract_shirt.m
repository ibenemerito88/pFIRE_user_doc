%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This script extracts and processes the solution from ShIRT. The
solution is written to the structure variable
shirt
which contains the field

name     String 
N        2D matrix with the coordinates of the nodes
U        2D matrix with the displacement of the nodes
%}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(strcat(dir_res,'/ShIRT'))
shirt.name='shirt';
shirt.N=importdata('nodes.txt');
shirt.N=shirt.N.data(:,2:4);
Ns=size(shirt.N,1);
shirt.U=importdata('disp.txt');
shirt.U=reshape(shirt.U.data,3,Ns)';
cd(init)