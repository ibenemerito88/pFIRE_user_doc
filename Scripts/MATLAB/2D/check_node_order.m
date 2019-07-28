%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This function prints the node step by step, in order to ensure they are
extracted from pFIRE in the right order.

Example of use:

check_node_order(shirt,pfire040,1)

%}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function check_node_order(method1,method2,step)
% To plot all the nodes use step=1, to plot only few of them increase the
% value of step
figure
for i=1:step:size(method1.N,1)
    plot(method1.N(i,1),method1.N(i,2),'ro')
    hold on
    plot(method2.N(i,1),method2.N(i,2),'bx')
    title(i)
    legend(method1.name,method2.name)
    pause(0.03)
end