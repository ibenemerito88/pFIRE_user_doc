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
sol = input('Select 2D solution: [1] 2D_Compr_X [2] 2D_expansion [3] 2D_shearx \n');

switch sol
    case 1
        sol = '2D_Compr_X';
    case 2
        sol = '2D_expansion';
    case 3
        sol = '2D_shearx';
end
dir_res = strcat('../../../Dataset/',sol,'/Results');
VoxelDimension = 1;

% Extract solution from ShIRT
extract_shirt
% Extract solution from pFIRE@0.4.0
extract_040
% Extract solution from pFIRE@devel
extract_devel


