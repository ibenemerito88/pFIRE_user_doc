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
from Tibia_Virtual of size 144x172x616 with nodal spacing 10;

%}

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Identify nodes on the top plane
maxz = find(shirt.N(:,3)==max(shirt.N(:,3)))';
discard = [];
n_plane = 19*17;
% Iterate over planes
for i=0:62 
    plane_index=i*n_plane+1:(i+1)*n_plane; %Index of the nodes in the plane
    % Discard rightmost column
    rightmost = plane_index(end-16:end);
    % Discard topmost 
    topmost=plane_index(17:17:end);
    bottommost=plane_index(1:17:end);
    discard = [discard rightmost topmost bottommost];
end
discard = unique([discard maxz]);
shred.name = 'ShIRT_reduced';
shred.N = shirt.N;
shred.N(discard,:)=[];
shred.U = shirt.U;
shred.U(discard,:) = [];

