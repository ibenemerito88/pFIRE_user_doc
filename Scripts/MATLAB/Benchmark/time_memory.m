%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
Script for postprocessing the wallclock time and memory comsumption of 
ShIRT, pFIRE@0.4.0 and pFIRE@devel.

The folder structure for the output is the same as in the Google Drive
folder. 

Images used for registration are cubes on side 

side = [1000 840 630 420 336 280 210 105]

which correpond to total number of voxel of 

nvoxels = [1000000000 592704000 250047000 74088000 37933056 21952000 9261000 1157625]

Simulations have been run on ShARC, using node 169 (large memory node) with
exclusive access. Nodal spacing is set to 20.


This set of scripts and function has been developed by 
Dr Ivan Benemerito, INSIGNO Institute for in silico medicine, Sheffield, UK
i.benemerito@sheffield.ac.uk

%}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all
clc

init = pwd;
dir_res = strcat('../../../Dataset/Benchmark');
cd(dir_res)



% Extract data
dat = importdata('pfire040.txt');
dat = dat.data;
side = dat(:,1);
voxels = dat(:,2);
pfire040.time = dat(:,3);
pfire040.memory = dat(:,4);

dat = importdata('pfiredevel.txt');
dat = dat.data;
pfiredev.time = dat(:,3);
pfiredev.memory = dat(:,4);

dat = importdata('shirt_runs.txt');
dat = dat.data;
shirt.time = dat(:,3);
shirt.memory = dat(:,4);

cd(init)

% Plot wallclock
plot(side,shirt.time,'k-x','linewidth',2)
hold on
plot(side,pfire040.time,'r-o','linewidth',2)
plot(side,pfiredev.time,'b-','linewidth',2)
xlabel('#voxels on side')
ylabel('Time [s]')
legend('shirt','0.4.0','dev')
title('Wall clock')

% Plot memory
figure
plot(side,shirt.memory,'k-x','linewidth',2)
hold on
plot(side,pfire040.memory,'r-o','linewidth',2)
plot(side,pfiredev.memory,'b-','linewidth',2)
xlabel('#voxels on side')
ylabel('Max memory [GB]')
legend('shirt','0.4.0','dev')
title('Memory')





