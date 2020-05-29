function [] = PlotMotor(yaw,forca,xyz_each_motor,k)

%% Fator de escala força
sc = 20;
%Escala motor
sc2=.55;
% tamanho helice
t = .25;
% tamanho motor
tm = .25;
% espessura
d = 0.02;

% ajuste para o plote
%  yaw =-yaw;
%Decomposição de Forças
Fx = 0 ;%*cos(yaw);
Fy = forca;% *sin(yaw);
Fz = 0;

%Vetor de forças
FX = [0 sc*Fx];
FY = [0 sc*Fy];
FZ = [0 sc*Fz];

% Matriz de rotação em Z
M_Z = NED2BF(yaw,eye(3));%[cos(yaw) -sin(yaw) 0; sin(yaw) cos(yaw) 0; 0 0 1];
%% SEMPRE QUE PLOTAR POSIÇÃO - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
M_rotacao = [M_Z [xyz_each_motor(2);xyz_each_motor(1);xyz_each_motor(3)]];

% Rotacao das forças
FF = M_rotacao * [FX;FY;FZ;ones(1,2)];

% Helice
xd = sc2*[-t  t  t -t];
yd = sc2*[-d -d  d  d];
zd = sc2*[ 0  0  0  0];

% Motor
xd1 = sc2*[-tm/3 tm/3 tm/3 -tm/3];
yd1 = sc2*[-tm/2 -tm/2 tm/2 tm/2];
zd1 = sc2*[0 0 0 0];

% Rotação helice
XY = M_rotacao * ([xd ;(yd+sc2*tm/2); zd; ones(1,length(xd))]);

% Rotação motor
M  = M_rotacao * ([xd1;yd1;zd1; ones(1,length(xd1))]);
%%
hold on
% Motor
fill3(M(1,:),M(2,:),M(3,:),[1 1 0.5],'linewidth',1)
% Helice
fill3(XY(1,:), XY(2,:),XY(3,:),[0 1 1],'linewidth',1)
% Força individual
plot3(FF(1,:), FF(2,:), FF(3,:),'r','linewidth',2);
switch k
    case '1'
        t = 'M1';
    case '2'
        t = 'M2';
    case '3'
        t = 'M3';
    case '4'
        t = 'M4';
    otherwise
        t ='';
end
text(xyz_each_motor(2),xyz_each_motor(1),t,'Interpreter','latex');
axis equal

end