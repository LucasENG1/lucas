function [] = PlotBarco() 
%%
PhysicalProperties;

global ROV 

yaw = 0;

% Matriz de Rotação (Rotação em Z)
M_rotacao = [cos(yaw) -sin(yaw) 0; 
             sin(yaw)  cos(yaw) 0; 
                    0         0 1];
                
% Bcl = largura do casco (maior que a linha dagua [0.1])
Bcl = ROV.Bw1 + 0.1;

%% Estrutura externa 
xd1 = [(ROV.dcbby-Bcl/2), (ROV.dcbby-Bcl/2)    , (ROV.dcbby)      , (ROV.dcbby+Bcl/2)    , (ROV.dcbby+Bcl/2),(ROV.dcbby-Bcl/2),(ROV.dcbby-Bcl/2)];
yd1 = [(Bcl/2)          , (ROV.Loa-Bcl-ROV.dcx), (ROV.Loa-ROV.dcx), (ROV.Loa-Bcl-ROV.dcx),  -ROV.dcx        , -ROV.dcx        , ( -Bcl/2)       ];

% Espelha a primeira parte do barço visto que ele é simétrico
xd2 = -xd1(end:-1:1);
yd2 =  yd1(end:-1:1);

% Monta todas as partes
xd  = [xd1 xd2];
yd  = [yd1 yd2];
zd  = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];

% Aplica a Rotação
XY = M_rotacao * ([xd;yd;zd] +[zeros(1,length(xd));(ROV.Loa/2)*ones(1,length(xd));zeros(1,length(xd))]);
% Ajuste devido a rotação ser no centro geometrico do veículo e a posição
% global está no centro de massa 
XY = XY - M_rotacao *[zeros(1,length(xd));(ROV.Loa/2)*ones(1,length(xd));zeros(1,length(xd))];

%% Plota da Figura
fill3(XY(1,:),XY(2,:),XY(3,:),[0.5 0.5 0.5],'linewidth',1);
axis equal
grid
end