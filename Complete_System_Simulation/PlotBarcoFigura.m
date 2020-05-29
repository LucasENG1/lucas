function [] = PlotBarcoFigura(X_Y_psi,Theta, PWM,F)
% Função para plotar o Barco em tamanho real 2D
% x   = Posição x do veículo no referencial Global
% y   = Posição y do veículo no referencial Global
% z   = Posição z do veículo no referencial Global
% yaw = Angulo de yaw do veículo no referencial fixo do corpo
%%
% aux= X_Y_psi;
% X_Y_psi(1,:) = aux(2,:);
% X_Y_psi(2,:) = aux(1,:);
yaw   = X_Y_psi(end,:);
global ROV DEG_TO_RAD;
for i=1:length(yaw)
    % Matriz de Rotação (Rotação em Z)
    M_rotacao = NED2BF(yaw(i),eye(3));
    
    % Bcl = largura do casco (maior que a linha dagua [0.001])
    Bcl = ROV.Bw1;
    
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
    
    % Aplica a Rotação ajustando a posição ao centro do desenho
    XY = M_rotacao * ([xd;yd;zd] +[zeros(1,length(xd));(ROV.Loa/2)*ones(1,length(xd));zeros(1,length(xd))]);
    % global está no centro de massa
    XY = XY - M_rotacao *[zeros(1,length(xd));(ROV.Loa/2)*ones(1,length(xd));zeros(1,length(xd))];
    FB = BF2NED(yaw(i),F(:,i));
    
    %% PLOT BARCO
    % SEMPRE QUE PLOTAR POSIÇÃO - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
    fill3(X_Y_psi(2,i) + XY(1,:), X_Y_psi(1,i) + XY(2,:),0 + XY(3,:),[0.5 0.5 0.5],'linewidth',1);
    
    % SEMPRE QUE PLOTAR POSIÇÃO - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
    plot3([X_Y_psi(2,i) X_Y_psi(2,i)+FB(2)],[X_Y_psi(1,i) X_Y_psi(1,i)+FB(1)],[0 0],'r','linewidth',2);
    plot3(X_Y_psi(2,i), X_Y_psi(1,i),0 ,'or','markersize',2);
    
    %% Plot dos Motores
    ang = X_Y_psi(3,i);
    ft = 3;
    % motor 1 (superior DIREITO)
    XYZ = Rot_pose_motor(ang,(ROV.dcbby),(ROV.Loa/ft));
    PlotMotor(Theta(1,i)*DEG_TO_RAD + ang,PWM(1,i)*ROV.k1, XYZ + [X_Y_psi(1:2,i);0],'')
    
    % motor 2 (inferior esquerdo)
    XYZ = Rot_pose_motor(ang,ROV.dceby,(-ROV.Loa/ft));
    PlotMotor(Theta(2,i)*DEG_TO_RAD + ang,PWM(2,i)*ROV.k1,XYZ + [X_Y_psi(1:2,i);0],'')
    
    % motor 3 (superior esquerdo)
    XYZ = Rot_pose_motor(ang,(ROV.dceby),(ROV.Loa/ft));
    PlotMotor(Theta(3,i)*DEG_TO_RAD + ang,PWM(3,i)*ROV.k1,XYZ + [X_Y_psi(1:2,i);0],'')
    
    % motor 4 (inferior direito)
    XYZ = Rot_pose_motor(ang,ROV.dcbby,(-ROV.Loa/ft));
    PlotMotor(Theta(4,i)*DEG_TO_RAD + ang,PWM(4,i)*ROV.k1,XYZ + [X_Y_psi(1:2,i);0],'');
    
end
grid on 
view(2)
end