%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This function produces superimposed quiver plot of the displacement field. 

Example of use:

quiver_disp(shirt,pfire040)

%}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function quiver_disp(method1,method2)
figure
quiver(method1.N(:,1),method1.N(:,2),method1.U(:,1),method1.U(:,2),'b')
hold on
quiver(method2.N(:,1),method2.N(:,2),method2.U(:,1),method2.U(:,2),'r')
legend(method1.name,method2.name)