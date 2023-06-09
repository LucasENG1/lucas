function PlotCenarioSimulado(Nboats,Nome,Language,salva)
global  Sim Sim_Plot TimeJ RAD_TO_DEG;

Img = ImageParametrization;
Leg = LegendLanguage(Language);

passo = floor(length(Sim_Plot.X_Y_psi(1,:))/Nboats); % Passo para plotar o Barco
XYpsi = Sim_Plot.X_Y_psi(:,1:passo:end);

F     = 0*XYpsi;%F(:,1:passo:end)/5;
Theta = zeros(4,length(XYpsi(1,:)));
PWM   = zeros(4,length(XYpsi(1,:)));

%% POSI��O 3D
switch Nome
    case 'Cenario1'
        Screen = [0 0 .5 1];
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
        plot(Sim_Plot.SP_Posi(2,:),Sim_Plot.SP_Posi(1,:),'r','linewidth',2);hold on;
        plot(Sim_Plot.X_Y_psi(2,:),Sim_Plot.X_Y_psi(1,:),'b','linewidth',2);
        PlotBarcoFigura(XYpsi,Theta, PWM,F);
end

xlabel('Y(m)',Img.YLabelOpt{:});
ylabel('X(m)',Img.XLabelOpt{:});
legend(Leg.p3D2{:},Img.Legend{:});

%% ============================================================= POSI��O 3L
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
    plot(TimeJ,Sim_Plot.X_Y_psi(3,:),'m','linewidth',2');grid on;
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
xlim([0 TimeJ(end)])

%% ====================================================== FOR�AS E ALOCA��O
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

plot(TimeJ,Sim.Theta(1,1:end-1),'b','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.Theta(2,1:end-1),'r','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.Theta(3,1:end-1),'g','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.Theta(4,1:end-1),'m','linewidth',2');hold on; grid on;
legend(Leg.ServoAngle{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});

xlim([0 TimeJ(end)]);

%% ============================================================= Servo PWM
servoPwm = figure(Img.figOpt1L{:});

plot(TimeJ,Sim.PWM(1,1:end-1),'b','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.PWM(2,1:end-1),'r','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.PWM(3,1:end-1),'g','linewidth',2');hold on; grid on;
plot(TimeJ,Sim.PWM(4,1:end-1),'m','linewidth',2');hold on; grid on;
legend(Leg.ServoPWM{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

xlim([0 TimeJ(end)]);
ylim([ 0 1]);
%% ============================================= Configura��o personalizada
switch Nome
    case 'Cenario1'
        figure(posi3D);
        xlabel('X (m)',Img.YLabelOpt{:});
        ylabel('Y (m)',Img.XLabelOpt{:});
        axis([ -2 142 -15 15]);
        legend(Leg.p3D{:},Img.Legend{:},'NumColumns',2,'Location','north');
        
        figure(posi3L)
        ylim(ax1,[0 150]);
        ylim(ax2,[-15 15]);
        ylim(ax3,[-50 100]);
        
        figure(vel3L)
        ylim(vx1,[-0.5 3.6]);
        xlim(vx1,[0 TimeJ(end)]);
        subplot(211)
        legend(Leg.VelXY{:},Img.Legend{:},'NumColumns',2,'Location','northeast');
        
        subplot(212)
        ylim([-150 150]);
        xlim([0 TimeJ(end)]);
        
        figure(servoAngle)
        ylim([-180 180])
        
        
    case 'Cenario2'
        figure(posi3D);
        axis([-17.5 17.5 -2.5 35]);
        legend(Leg.p3D{:},Img.Legend{:},'NumColumns',2,'Location','north');
        
        figure(vel3L)
        ylim(vx1,[-0.6 2.]);
        xlim(vx1,[0 TimeJ(end)]);
        subplot(211)
        legend(Leg.VelXY{:},Img.Legend{:},'NumColumns',2,'Location','northeast');
        
        subplot(212)
        ylim([-80 20]);
        xlim([0 TimeJ(end)]);
        
        figure(servoAngle)
        ylim([-180 180])
        
        
    case 'Cenario3'
        figure(posi3D);
        axis([-2 32 -2 35]);
        legend(Leg.p3D2{:},Img.Legend{:},'NumColumns',2,'Location','north');
        
        figure(vel3L)
        ylim(vx1,[-1.2 1.2]);
        xlim(vx1,[0 TimeJ(end)]);
        subplot(211)
        legend(Leg.VelXY{:},Img.Legend{:},'NumColumns',2,'Location','northeast');
        
        subplot(212)
        axis([0 160 -5 15]);
        
        figure(servoAngle)
        axis([0 160 -160 150]);
        
        
    otherwise
end

if(salva==1)
    saveas(posi3D,strcat('Sim_EPS_output/',strcat(Nome,'Posicao3D')),'epsc');
    saveas(posi3D,strcat('Sim_FIG_output/',strcat(Nome,'Posicao3D')),'fig');
    
    saveas(posi3L,strcat('Sim_EPS_output/',strcat(Nome,'Posicao3L')),'epsc');
    saveas(posi3L,strcat('Sim_FIG_output/',strcat(Nome,'Posicao3L')),'fig');
    
    saveas(vel3L,strcat('Sim_EPS_output/',strcat(Nome,'Velocidade2L')),'epsc');
    saveas(vel3L,strcat('Sim_FIG_output/',strcat(Nome,'Velocidade2L')),'fig');
    
    saveas(force,strcat('Sim_EPS_output/',strcat(Nome,'Forca')),'epsc');
    saveas(force,strcat('Sim_FIG_output/',strcat(Nome,'Forca')),'fig');
    
    saveas(servoAngle,strcat('Sim_EPS_output/',strcat(Nome,'Angle')),'epsc');
    saveas(servoAngle,strcat('Sim_FIG_output/',strcat(Nome,'Angle')),'fig');
    
    saveas(servoPwm,strcat('Sim_EPS_output/',strcat(Nome,'PWM')),'epsc');
    saveas(servoPwm,strcat('Sim_FIG_output/',strcat(Nome,'PWM')),'fig');
    
    
end

end

