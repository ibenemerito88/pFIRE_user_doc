%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This function prints the node one by one, in order to ensure they are
extracted from pFIRE in the right order.

Example of use:

check_node_order(shirt,pfire040)

%}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function check_node_order(method1,method2)
step = 10;
% To plot all the nodes use step=1, to plot only few of them increase the
% value of step
figure
for i=1:step:size(method1.N,1)
    plot3(method1.N(i,1),method1.N(i,2),method1.N(i,3),'ro')
    hold on
    plot3(method2.N(i,1),method2.N(i,2),method2.N(i,3),'bx')
    title(i)
    legend(method1.name,method2.name)
    pause(0.03)
end