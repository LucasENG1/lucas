function FiguraAutopilot(spd,ayp,SP_PosiIAE,salva)
global Sim_Plot;

% Posição
posi = Sim_Plot.X_Y_psi;

% Setpoint
SP_x = SP_PosiIAE(1,:);
SP_y = SP_PosiIAE(2,:);

% Espaço entre os plotes
G = 10*150;

% Forças e angulos
F     = 0*posi;%F(:,1:passo:end)/5;
Theta = zeros(4,length(posi(1,:)));
PWM   = zeros(4,length(posi(1,:)));

% Opções de Figura
Screen = [0.1 0.1 .55 .65];
figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto','Position',Screen,'InnerPosition',Screen};

figure(figOpt{:});grid on;
hold on
% SetPoint
s1 = plot(SP_y(1:G:end),SP_x(1:G:end),'--or','markersize',10,'linewidth',1.5);
% Caminho Executado
s2 = plot(posi(2,1:end),posi(1,1:end),'-','markersize',10,'linewidth',1);
% Direção do L_wp
s3 = plot([posi(2,1:G:end); SP_y(1:G:end)],[posi(1,1:G:end); SP_x(1:G:end)],'m','linewidth',2); % L1
% Velocidade em x
s4 = plot([posi(2,1:G:end); posi(2,1:G:end)+spd(2,1:G:end)],[posi(1,1:G:end); posi(1,1:G:end)+spd(1,1:G:end)],'b','linewidth',2);
% Aceleração em y
s5 = plot([posi(2,1:G:end); posi(2,1:G:end)+ayp(2,1:G:end)],[posi(1,1:G:end); posi(1,1:G:end)+ayp(1,1:G:end)],'g','linewidth',2);
% Veículo
PlotBarcoFigura([posi(1,1:G:end);posi(2,1:G:end);posi(3,1:G:end)],Theta, PWM,F);

hold off;

st1 = [s1(1) s2(1) s3(1) s4(1) s5(1)];

legend(st1,'SetPoint','Caminho executado','Dire\c{c}\~ao de $L_{WP}$',...
    'Velocidade em $x$','Acelera\c{c}\~ao em $y$','Interpreter','latex','Location','best');
drawnow
if(salva==1)
    saveas(gcf,strcat('Autopilot'),'epsc');
end
end