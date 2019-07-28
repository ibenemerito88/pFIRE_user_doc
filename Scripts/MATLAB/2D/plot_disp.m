%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This function produces plot of the displacement fields, superimposed. 

Example of use:

plot_disp(shirt,pfire040)

%}
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_disp(method1,method2)
figure
subplot(1,2,1)
plot(method1.U(:,1))
hold on
plot(method2.U(:,1))
title('x component')
legend(method1.name,method2.name)
subplot(1,2,2)
plot(method1.U(:,2))
hold on
plot(method2.U(:,2))
title('y component')
legend(method1.name,method2.name)