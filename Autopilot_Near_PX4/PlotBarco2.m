function [] = PlotBarco(i) 
%% 
% Fun��o para plotar o Barco em tamanho real 2D
% x   = Posi��o x do ve�culo no referencial Global
% y   = Posi��o y do ve�culo no referencial Global
% z   = Posi��o z do ve�culo no referencial Global
% yaw = Angulo de yaw do ve�culo no referencial fixo do corpo
%%
global ROV Sim;

% Ajuste para plotar o ve�culo pois ele � desenhado com o eixo y no nariz
% por�m  o referencial do memso utiliza o eixo x
yaw = Sim.Current_X_Y_psi(3);
% yaw = yaw - pi/2;

% Matriz de Rota��o (Rota��o em Z)
M_rotacao = NED2BF(yaw,eye(3));

% Bcl = largura do casco (maior que a linha dagua [0.001])
Bcl = ROV.Bw1;

%% Estrutura externa 
xd1 = [(ROV.dcbby-Bcl/2), (ROV.dcbby-Bcl/2)    , (ROV.dcbby)      , (ROV.dcbby+Bcl/2)    , (ROV.dcbby+Bcl/2),(ROV.dcbby-Bcl/2),(ROV.dcbby-Bcl/2)];
yd1 = [(Bcl/2)          , (ROV.Loa-Bcl-ROV.dcx), (ROV.Loa-ROV.dcx), (ROV.Loa-Bcl-ROV.dcx),  -ROV.dcx        , -ROV.dcx        , ( -Bcl/2)       ];

% Espelha a primeira parte do bar�o visto que ele � sim�trico
xd2 = -xd1(end:-1:1);
yd2 =  yd1(end:-1:1);

% Monta todas as partes
xd  = [xd1 xd2];
yd  = [yd1 yd2];
zd  = [0 0 0 0 0 0 0 0 0 0 0 0 0 0 ];

% Aplica a Rota��o ajustando a posi��o ao centro do desenho
XY = M_rotacao * ([xd;yd;zd] +[zeros(1,length(xd));(ROV.Loa/2)*ones(1,length(xd));zeros(1,length(xd))]);
% global est� no centro de massa 
XY = XY - M_rotacao *[zeros(1,length(xd));(ROV.Loa/2)*ones(1,length(xd));zeros(1,length(xd))];
X=10;
 FB = zeros(3,1);%BF2NED(yaw,Sim.F(:,i));
%% Plota da Figura
%% SEMPRE QUE PLOTAR POSI��O - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
fill3(Sim.Current_X_Y_psi(2) + XY(1,:), Sim.Current_X_Y_psi(1) + XY(2,:),0 + XY(3,:),[0.5 0.5 0.5],'linewidth',1);
hold on

%% SEMPRE QUE PLOTAR POSI��O - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
% plot3([Sim.Current_X_Y_psi(2) Sim.Current_X_Y_psi(2)+0*FB(2)/X],[Sim.Current_X_Y_psi(1) Sim.Current_X_Y_psi(1)+0.2+0*FB(1)/X],[0 0],'r','linewidth',2);
plot3(Sim.Current_X_Y_psi(2),Sim.Current_X_Y_psi(1),0 ,'or','markersize',5);
hold off
grid
view(2)

end