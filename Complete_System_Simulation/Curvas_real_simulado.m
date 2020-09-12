function Curvas_real_simulado(Nboats,Nome,Language,salva)
global  Sim Sim_Plot TimeJ RAD_TO_DEG;

Img = ImageParametrization;
Leg = LegendLanguage(Language);

%% FIGURA POSIÇÃO COM BARCO
passo = floor(length(Sim_Plot.X_Y_psi(1,:))/Nboats); % Passo para plotar o Barco
XYpsi = Sim_Plot.X_Y_psi(:,1:passo:end);

F     = 0*XYpsi;%F(:,1:passo:end)/5;
Theta = zeros(4,length(XYpsi(1,:)));
PWM   = zeros(4,length(XYpsi(1,:)));

% Utilizar essa se quiser ver os angulos e PWMs no plot
% F     = 0.*Sim.F(:,1:passo:end)/10;
% Theta = Sim.Theta(:,2:passo:end);
% PWM   = Sim.PWM(:,2:passo:end);

%% POSIÇÃO 3D
switch Nome
    case 'Linear'
        Screen = [0 0 1 1];
        figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto','Position',Screen};
        posi3D = figure(figOpt{:});
        
        Ax = Sim_Plot.X_Y_psi(2,:);
        Sim_Plot.X_Y_psi(2,:)= Sim_Plot.X_Y_psi(1,:);
        Sim_Plot.X_Y_psi(1,:) = Ax;
        Sim_Plot.X_Y_psi(3,:) = Sim_Plot.X_Y_psi(1,:) +pi/2;
        XYpsi = Sim_Plot.X_Y_psi(:,1:passo:end);
        
        plot(Sim_Plot.SP_Posi(1,:),Sim_Plot.SP_Posi(2,:),'r','linewidth',2);hold on;axis equal
        plot(Sim_Plot.X_Y_psi(2,:),Sim_Plot.X_Y_psi(1,:),'b','linewidth',2);
        PlotBarcoFigura(XYpsi,Theta, PWM,F);
        
        Ax = Sim_Plot.X_Y_psi(2,:);
        Sim_Plot.X_Y_psi(2,:)= Sim_Plot.X_Y_psi(1,:);
        Sim_Plot.X_Y_psi(1,:) = Ax;
        Sim_Plot.X_Y_psi(3,:) = Sim_Plot.X_Y_psi(1,:) -pi/2;
        XYpsi = Sim_Plot.X_Y_psi(:,1:passo:end);
    otherwise
        posi3D = figure(Img.figOpt{:});
        plot(Sim_Plot.SP_Posi(2,:),Sim_Plot.SP_Posi(1,:),'r','linewidth',2);hold on;axis equal
        plot(Sim_Plot.X_Y_psi(2,:),Sim_Plot.X_Y_psi(1,:),'b','linewidth',2);
        PlotBarcoFigura(XYpsi,Theta, PWM,F);
end

% plot(Sim_Plot.SP_Posi(2,:),Sim_Plot.SP_Posi(1,:),'r','linewidth',2);hold on;axis equal
% plot(Sim_Plot.X_Y_psi(2,:),Sim_Plot.X_Y_psi(1,:),'b','linewidth',2);
% PlotBarcoFigura(XYpsi,Theta, PWM,F);

xlabel('Y(m)',Img.YLabelOpt{:});
ylabel('X(m)',Img.XLabelOpt{:});
legend(Leg.p3D2{:},Img.Legend{:});

%% ============================================================= POSIÇÃO 3L
posi3L = figure(Img.figOpt3L{:});

ax1 = subplot(311);
plot(TimeJ,Sim_Plot.SP_Posi(1,:),'r','linewidth',2);hold on; grid on;
plot(TimeJ,Sim_Plot.X_Y_psi(1,:),'b','linewidth',2');

xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YP3L{:},Img.YLabelOpt{:});
legend(Leg.posicaoX3L{:},Img.Legend{:});

ax2 = subplot(312);
plot(TimeJ,Sim_Plot.SP_Posi(2,:),'r','linewidth',2);hold on; grid on;
plot(TimeJ,Sim_Plot.X_Y_psi(2,:),'b','linewidth',2');

xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YP3L{:},Img.YLabelOpt{:});
legend(Leg.posicaoY3L{:},Img.Legend{:});

ax3 = subplot(313);
if strcmp(Nome,'Circular')==1
    plot(TimeJ,Sim_Plot.SP_Posi(3,:)*RAD_TO_DEG,'r','linewidth',2); hold on;grid on;
    plot(TimeJ,Sim_Plot.X_Y_psi(3,:)*RAD_TO_DEG,'b','linewidth',2');
    legend(Leg.posicaoYaw3L{:},Img.Legend{:});
else
    plot(TimeJ,Sim_Plot.X_Y_psi(3,:)*RAD_TO_DEG,'m','linewidth',2');grid on;
    legend(Leg.posicaoYaw3L{1},Img.Legend{:});
end
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.yaw3L{:},Img.YLabelOpt{:});

linkaxes([ax1 ax2 ax3],'x')
xlim([0 TimeJ(end)])

%% ============================================================= VELOCIDADE
vel3L = figure(Img.figOpt2L{:});

vx1 = subplot(211);
% plot(TimeJ,Sim_Plot.SP_Vel(1,:),'r','linewidth',2');
plot(TimeJ,Sim_Plot.u_v_r(1,:),'linewidth',2'); hold on; grid on;

% legend(Leg.VelX3L{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YV3L{:},Img.YLabelOpt{:});

% vx2 = subplot(312);
% plot(TimeJ,Sim_Plot.SP_Vel(2,:),'r','linewidth',2'); hold on; grid on;
plot(TimeJ,Sim_Plot.u_v_r(2,:),'linewidth',2');

legend(Leg.VelXY{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YV3L{:},Img.YLabelOpt{:});

vx3 = subplot(212);
% plot(TimeJ,Sim_Plot.SP_Vel(3,:)*RAD_TO_DEG,'r','linewidth',2'); hold on;
plot(TimeJ,Sim_Plot.u_v_r(3,:)*RAD_TO_DEG,'b','linewidth',2'); grid on;
legend(Leg.VelYaw{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YYaw3L{:},Img.YLabelOpt{:});

linkaxes([vx1 vx3],'x')

%% ====================================================== FORÇAS E ALOCAÇÃO
force = figure(Img.figOpt3L{:});
axf1 = subplot(311);
plot(TimeJ,Sim.F(1,:),'r','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.F_out(1,1:end),'b','linewidth',2');

legend(Leg.AlocacaoX{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Forca{:},Img.YLabelOpt{:});

axf2 = subplot(312);
plot(TimeJ,Sim.F(2,:),'r','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.F_out(2,1:end),'b','linewidth',2');

legend(Leg.AlocacaoY{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Forca{:},Img.YLabelOpt{:});

axf3 = subplot(313);
plot(TimeJ,Sim.F(3,:),'r','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.F_out(3,1:end),'b','linewidth',2');

legend(Leg.AlocacaoPsi{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Torque{:},Img.YLabelOpt{:});

linkaxes([axf1 axf2 axf3],'x')
linkaxes([axf1 axf2 ],'y')
xlim([0 TimeJ(end)])
%% ============================================================ Servo Angle
servoAngle = figure(Img.figOpt1L{:});
% axSa1 = subplot(411);
plot(TimeJ,Sim.Theta(1,1:end-1),'b','linewidth',2');hold on; grid on;
% legend(Leg.ServoAngle1{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% axSa2 = subplot(412);
plot(TimeJ,Sim.Theta(2,1:end-1),'r','linewidth',2');hold on; grid on;
% legend(Leg.ServoAngle2{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% axSa3 = subplot(413);
plot(TimeJ,Sim.Theta(3,1:end-1),'g','linewidth',2');hold on; grid on;
% legend(Leg.ServoAngle3{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% axSa4 = subplot(414);
plot(TimeJ,Sim.Theta(4,1:end-1),'m','linewidth',2');hold on; grid on;
legend(Leg.ServoAngle{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% linkaxes([axSa1 axSa2 axSa3 axSa4],'xy')
xlim([0 TimeJ(end)]);
% ylim([-120 120]);

% plot(TimeJ,Sim.Theta(2,1:end-1),'linewidth',2')
% plot(TimeJ,Sim.Theta(3,1:end-1),'linewidth',2')
% plot(TimeJ,Sim.Theta(4,1:end-1),'linewidth',2')

% plot(TimeJ,Sim.T(1,1:end),'linewidth',2');hold on; grid on;
% plot(TimeJ,Sim.T(2,1:end),'linewidth',2')
% plot(TimeJ,Sim.T(3,1:end),'linewidth',2')
% plot(TimeJ,Sim.T (4,1:end),'linewidth',2')

%% ============================================================= Servo PWM
servoPwm = figure(Img.figOpt1L{:});
% axPa1 = subplot(411);

plot(TimeJ,Sim.PWM(1,1:end-1),'b','linewidth',2');hold on; grid on;
% legend(Leg.ServoPWM1{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% axPa2 = subplot(412);
plot(TimeJ,Sim.PWM(2,1:end-1),'r','linewidth',2');hold on; grid on;
% legend(Leg.ServoPWM2{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% axPa3 = subplot(413);
plot(TimeJ,Sim.PWM(3,1:end-1),'g','linewidth',2');hold on; grid on;
% legend(Leg.ServoPWM3{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% axPa4 = subplot(414);
plot(TimeJ,Sim.PWM(4,1:end-1),'m','linewidth',2');hold on; grid on;
legend(Leg.ServoPWM{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% linkaxes([axPa1 axPa2 axPa3 axPa4],'xy')

xlim([0 TimeJ(end)]);
ylim([ 0 1]);
%% ============================================= Configuração personalizada
switch Nome
    case 'Linear'
        figure(posi3D);
        xlabel('X (m)',Img.YLabelOpt{:});
        ylabel('Y (m)',Img.XLabelOpt{:});
        axis([ -2 143 -10 10]);
        ylim(ax1,[0 150]);
        ylim(ax2,[-15 15]);
        ylim(ax3,[-50 100]);
        legend(Leg.p3D{:},Img.Legend{:},'NumColumns',2,'Location','northoutside');
        
        figure(vel3L)
        ylim(vx1,[-1 4]);
%         ylim(vx2,[-0 4]);
%         ylim(vx3,[-20  20]);
        xlim([0 TimeJ(end)])
        
        figure(force)
        xlim(axf1,[0 TimeJ(end)])
        
    case 'Oito'
        figure(posi3D);
        axis([-15 8 23 79])
        legend(Leg.p3D{:},Img.Legend{:},'NumColumns',1,'Location','northoutside');
        
        figure(vel3L)
        ylim(vx1,[-0 1.5]);
%         ylim(vx2,[-1 1]);
        ylim(vx3,[-20  20]);
        xlim([0 TimeJ(end)])
        
    case 'Sway'
        figure(posi3D);
        axis([-2 70 -2 5]);
        
        figure(posi3L)
        ylim(ax1,[-1 60]);
        ylim(ax2,[0  70]);
        ylim(ax3,[0  200]);
        xlim([0 TimeJ(end)])
        
        figure(vel3L)
        ylim(vx1,[-2 3]);
%         ylim(vx2,[-2 3]);
        ylim(vx3,[-75  70]);
        xlim([0 TimeJ(end)]);
        
    case 'Circular'
        figure(posi3D);
        axis([-17.5 17.5 -2.5 32.5]);
        
        figure(posi3L)
        %         ylim(ax1,[10.25-20 10.25+20]);
        %         ylim(ax2,[11.25-20 11.25+20]);
        %         ylim(ax3,[-190  190]);
        xlim([0 TimeJ(end)])
        
        figure(vel3L)
        ylim(vx1,[-1 2]);
%         legend(Leg.VelXY{:},Img.Legend{:});
%         ylim(vx3,[-20 20]);
        xlim([0 TimeJ(end)])
    otherwise
end

if(salva==1)
    saveas(posi3D,strcat('Figures/',strcat(Nome,'Posicao3D')),'epsc');
    saveas(posi3D,strcat('Figures/',strcat(Nome,'Posicao3D')),'fig');
    
    saveas(posi3L,strcat('Figures/',strcat(Nome,'Posicao3L')),'epsc');
    saveas(posi3L,strcat('Figures/',strcat(Nome,'Posicao3L')),'fig');
    
    saveas(vel3L,strcat('Figures/',strcat(Nome,'Velocidade2L')),'epsc');
    saveas(vel3L,strcat('Figures/',strcat(Nome,'Velocidade2L')),'fig');
    
    saveas(force,strcat('Figures/',strcat(Nome,'Forca')),'epsc');
    saveas(force,strcat('Figures/',strcat(Nome,'Forca')),'fig');
    
    saveas(servoAngle,strcat('Figures/',strcat(Nome,'Angle')),'epsc');
    saveas(servoAngle,strcat('Figures/',strcat(Nome,'Angle')),'fig');
    
    saveas(servoPwm,strcat('Figures/',strcat(Nome,'PWM')),'epsc');
    saveas(servoPwm,strcat('Figures/',strcat(Nome,'PWM')),'fig');
    
    
end

end

