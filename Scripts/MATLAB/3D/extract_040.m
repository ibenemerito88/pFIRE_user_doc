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

cd(strcat('../../../Dataset/',sol,'/Results/pFIRE@0.4.0'))
pfire040.name = 'pfire@0.4.0';

% Extract nodal coordinates and construct the grid
x=h5read('map.xdmf.h5','/map/nodes_x')*VoxelDimension/1000;
y=h5read('map.xdmf.h5','/map/nodes_y')*VoxelDimension/1000;
z=h5read('map.xdmf.h5','/map/nodes_z')*VoxelDimension/1000;
[Map02.x,Map02.y,Map02.z]=meshgrid(z,y,x);

% Extract displacement
Map02.u=h5read('map.xdmf.h5','/map/x')*VoxelDimension/1000;
Map02.v=h5read('map.xdmf.h5','/map/y')*VoxelDimension/1000;
Map02.w=h5read('map.xdmf.h5','/map/z')*VoxelDimension/1000;
% Transpose the displacement matrix to have the correct size
tras = [2 1 3];
Map02.u=permute(Map02.u,tras);
Map02.v=permute(Map02.v,tras);
Map02.w=permute(Map02.w,tras);

% Write output files
Lx=size(Map02.x,1);
Ly=size(Map02.y,2);
Lz=size(Map02.z,3);
Lremx=0;
Lremy=0;
Lremz=0;

disp('write nodes file for ANSYS');
Nodes = 'nodes.txt';
FileIDNod = fopen(Nodes,'w+');
for k=(1+Lremz):(Lz-Lremz)
    for j=(1+Lremx):(Ly-Lremx)
        for i=(1+Lremy):(Lx-Lremy)
            fprintf(FileIDNod,'%1s, %0i, %0.6f, %0.6f, %0.6f\r\n', 'N',(k-1)*(Ly-2*Lremy)*(Lx-2*Lremx)+(j-1)*(Lx-2*Lremx)+i,Map02.x(i,j,k), Map02.y(i,j,k), Map02.z(i,j,k));
            [i j k];
        end
    end
end
pfire040.N=importdata('nodes.txt');
pfire040.N=pfire040.N.data(:,2:4);
Np040=size(pfire040.N,1);

disp('write elements file for ANSYS');
Elements = 'elements.txt';
FileIDElem = fopen(Elements,'w+');
for k=(1+Lremz):(Lz-Lremz-1)
    for j=(1+Lremy):(Ly-Lremy-1)
        for i=(1+Lremx):(Lx-Lremx-1)
            fprintf(FileIDElem,'%1s, %1i, %1i, %1i, %1i, %1i, %1i, %1i, %1i \r\n', 'E' , ((k-1)*(Ly-2*Lremy)*(Lx-2*Lremx) + (j-1)*(Lx-2*Lremx)+(i-1)+1), ((k-1)*(Ly-2*Lremy)*(Lx-2*Lremx)+ (j-1)*(Lx-2*Lremx)+ (i-1+1)+1), ((k-1)*(Ly-2*Lremy)*(Lx-2*Lremx) + (j-1+1)*(Lx-2*Lremx)+(i-1+1)+1), ((k-1)*(Ly-2*Lremy)*(Lx-2*Lremx) + (j-1+1)*(Lx-2*Lremx)+(i-1)+1), ((k-1+1)*(Ly-2*Lremy)*(Lx-2*Lremx) + (j-1)*(Lx-2*Lremx)+(i-1)+1), ((k-1+1)*(Ly-2*Lremy)*(Lx-2*Lremx) + (j-1)*(Lx-2*Lremx)+(i-1+1)+1), ((k-1+1)*(Ly-2*Lremy)*(Lx-2*Lremx) + (j-1+1)*(Lx-2*Lremx)+(i-1+1)+1), ((k-1+1)*(Ly-2*Lremy)*(Lx-2*Lremx) + (j-1+1)*(Lx-2*Lremx)+(i-1)+1));
        end
    end
end
pfire040.E=importdata('elements.txt');
pfire040.E=pfire040.E.data;

% ===
disp('write displacements for ANSYS');
Displ = 'disp.txt';
FileIDDis = fopen(Displ,'w+');
for k=(1+Lremz):(Lz-Lremz)
    for j=(1+Lremy):(Ly-Lremy)
        for i=(1+Lremx):(Lx-Lremx)
            fprintf(FileIDDis,'%1s, %0i, %1s, %0.12f\r\n', 'D',(k-1)*(Ly-2*Lremy)*(Lx-2*Lremx)+(j-1)*(Lx-2*Lremx)+i, 'ux', Map02.u(i,j,k));
            fprintf(FileIDDis,'%1s, %0i, %1s, %0.12f\r\n', 'D',(k-1)*(Ly-2*Lremy)*(Lx-2*Lremx)+(j-1)*(Lx-2*Lremx)+i, 'uy', Map02.v(i,j,k));
            fprintf(FileIDDis,'%1s, %0i, %1s, %0.12f\r\n', 'D',(k-1)*(Ly-2*Lremy)*(Lx-2*Lremx)+(j-1)*(Lx-2*Lremx)+i, 'uz', Map02.w(i,j,k));
            
        end
    end
end
pfire040.U=importdata('disp.txt');
pfire040.U=reshape(pfire040.U.data,3,Np040)';
pfire040.U(:,[1 3])=pfire040.U(:,[3 1]);

pfire040.reg=h5read('registered.xdmf.h5','/registered');
pfire040.Map=Map02;
cd(init)


