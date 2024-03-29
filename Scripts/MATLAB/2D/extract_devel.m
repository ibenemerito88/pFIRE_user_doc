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

% Extract nodal coordinates and construct the grid.
x=h5read('map.xdmf.h5','/map/nodes_x')*VoxelDimension/1000;
y=h5read('map.xdmf.h5','/map/nodes_y')*VoxelDimension/1000;
z=0;
[Map02.x,Map02.y,Map02.z]=meshgrid(y,x,z);

% Extract displacement
Map02.u = h5read('map.xdmf.h5','/map/x')*VoxelDimension/1000;
Map02.v = h5read('map.xdmf.h5','/map/y')*VoxelDimension/1000;
Map02.u = permute(Map02.u,[2 1 3]);
Map02.v = permute(Map02.v,[2 1 3]);

% There is a 90 degrees rotation between pfire@dev and ShIRT. 
% Apply 90 degrees clockwise rotation by inverting the coordinates
temp = Map02.v;
Map02.v = Map02.u;
Map02.u = temp;
Map02.w = zeros(size(Map02.u));

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
pfiredev.N=importdata('nodes.txt');
pfiredev.N=pfiredev.N.data(:,2:4);
Npdev=size(pfiredev.N,1);

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
pfiredev.U=importdata('disp.txt');
pfiredev.U=reshape(pfiredev.U.data,3,Npdev)';

pfiredev.reg=h5read('registered.xdmf.h5','/registered');
pfiredev.Map = Map02;
cd(init)


