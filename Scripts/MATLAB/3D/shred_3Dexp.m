%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
This script extracts from ShIRT the solution on the same nodes as 
pFIRE@devel. The solution is written to the structure variable
shred
which contains the field

name     String 
N        2D matrix with the coordinates of the nodes
U        2D matrix with the displacement of the nodes

This script is not general and can be applied only to processing of results
from ET3 with nodal spacing 20;

%}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
return
% Identify nodes on the top and bottom plane
minz = find(shirt.N(:,3)==min(shirt.N(:,3)))';
maxz = find(shirt.N(:,3)==max(shirt.N(:,3)))';
discard = [];
% Iterate over planes
for i=1:11
    plane_index=i*169+1:(i+1)*169; %Index of the nodes in the plane
    % Discard formost left and right
    leftright=plane_index([1:13 end-12:end]);
    % Discard topmost 
    topmost=plane_index(13:13:end);
    botmost=plane_index(1:13:end);
    discard = [discard leftright topmost botmost];
end
discard = unique([discard minz maxz]);
shred.name = 'ShIRT_reduced';
shred.N = shirt.N;
shred.N(discard,:)=[];
shred.U = shirt.U;
shred.U(discard,:) = [];
