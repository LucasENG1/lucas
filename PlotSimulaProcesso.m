% Plot da simulação do Robô
% ------ Plot dos resultados-----

% Corpo do Robô
RoboC = T2D(Rz2D(Corpo, P(3)), P(1), P(2)); % incremental
% Roda Esquerda do Robô
RoboE = T2D(Rz2D(RodaE, P(3)), P(1), P(2)); % incremental
% Roda Direita do Robô
RoboD = T2D(Rz2D(RodaD, P(3)), P(1), P(2)); % incremental

% --- plot ---
plot([Pini(1) G(1)] , [Pini(2) G(2)] , 'g', 'linewidth', 2); hold on;
plot(G(1) , G(2) , 'ok' , 'linewidth' , 2 , 'markersize' , 8);
% Robô
fill(RoboC(1,:) , RoboC(2,:) , 'r') % corpo
fill(RoboE(1,:) , RoboE(2,:) , 'k') % roda esquerda
fill(RoboD(1,:) , RoboD(2,:) , 'k') % roda direita

% Histórico de posições: o 'rastro' do Robô, onde ele passou.
plot(R(1,:) , R(2,:) , 'b' , 'linewidth' , 2);
% Orientação atual do Robô: para onde ele aponta no momento atual 't'
plot([P(1) P(1)+0.1*cos(P(3))] , [P(2) P(2)+0.1*sin(P(3))] , 'k' , 'linewidth' , 2)
% Eixo das rodas
plot([P(1) P(1)+1*cos(P(3)+pi/2)] , [P(2) P(2)+1*sin(P(3)+pi/2)] , 'k' , 'linewidth' , 2)
plot([P(1) P(1)+1*cos(P(3)-pi/2)] , [P(2) P(2)+1*sin(P(3)-pi/2)] , 'k' , 'linewidth' , 2)
hold off; axis equal; grid on;xlabel('x');ylabel('y');set(gcf,'color','w');
title(sprintf('t = %.2fs, Erro = %.2fm' , t , Erro(end))) ; drawnow;