%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This script extracts and processes the solution from ShIRT. The
solution is written to the structure variable
shirt
which contains the field

name     String 
N        2D matrix with the coordinates of the nodes
E        2D matrix containing the nodes which form the tetrahedral elements
U        2D matrix with the displacement of the nodes
%}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cd(strcat(dir_res,'/ShIRT'))
shirt.name='shirt';
shirt.N=importdata('nodes.txt');
shirt.N=shirt.N.data(:,2:4);
shirt.E=importdata('elements.txt');
shirt.E=shirt.E.data;
Ns=size(shirt.N,1);
shirt.U=importdata('disp.txt');
shirt.U=reshape(shirt.U.data,3,Ns)';
cd(init)