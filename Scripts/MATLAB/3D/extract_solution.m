%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Scripts for postprocessing the output file from pFIRE@0.4.0 and
pfire@devel. 

The folder structure for the output is the same as in the Google Drive
folder. 

This set of scripts and function has been developed by 
Dr Ivan Benemerito, INSIGNO Institute for in silico medicine, Sheffield, UK
i.benemerito@sheffield.ac.uk

FUNCTIONS AND SCRIPTS:

extract_solution
    Main scripts.
extract_shirt
    Extracts the solution of ShIRT and puts it into a structure.
extract_040
    Extracts the solution of pFIRE@0.4.0, puts it into a structure and
    prints the corresponding .txt files
extract_devel
    Extracts the solution of pFIRE@devel, puts it into a structure and
    prints the corresponding .txt files
shred_***
    *** can be either ET3 or Tibia. This script extracts from ShIRT the
    solution on the same nodes as pFIRE@devel.
plot_disp
    Function for comparing the nodal displacement from two methods. It 
    accepts as input the structure of the methods, and produces a graph 
    which superimpose the displacement in the x and y directions. 
quiver_disp
    Function for visualising the displacement fields from two methods. It 
    accepts as input the structure of the methods, and produces
    superimposed quiver plots of the displacement.
check_node_order
    Function for verifying that the nodes of pFIRE@0.4.0 are ordered in the
    same way as ShIRT. Currently the same thing is not implemented for
    pFIRE@devel as it is not functioning correctly.

%}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
close all
clc

init = pwd;
% Choose the solution to visualise
sol = input('Select 3D solution: [1] ET3 (zero strain) [2] Tibia [3] 3D_expansion \n');

switch sol
    case 1
        sol = 'ET3';
        VoxelDimension = 9.96;
    case 2
        sol = 'Tibia_Virtual';
        VoxelDimension = 31.2;
    case 3
        sol = '3D_expansion';
        VoxelDimension = 1;
end
dir_res = strcat('../../../Dataset/',sol,'/Results');
% Choose values for mask
v = [.8 .8 .8];

% Extract solution from ShIRT
extract_shirt
shirt_masked = apply_mask(shirt,v);
% Extract solution from pFIRE@0.4.0
read_040
pfire040_masked = apply_mask(pfire040,v);
% extract_040
% Extract solution from pFIRE@devel
read_devel
% extract_devel
plot_disp(shirt,pfire040)
plot_disp(shirt_masked,pfire040_masked)

return
% Extract from ShIRT the solution on the same nodes of pFIRE@devel
if strcmp(sol,'ET3')
    shred_ET3
elseif strcmp(sol,'Tibia_Virtual')
    shred_Tibia
elseif strcmp(sol,'3D_expansion')
    shred_3Dexp
end


