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
% F     = Sim.F(:,1:passo:end)/5;
% Theta = Sim.Theta(:,2:passo:end);
% PWM   = Sim.PWM(:,2:passo:end);

%% POSIÇÃO 3D
switch Nome
    case 'LinearX'
        Screen = [0 0 1 1];
        figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto','Position',Screen};
        posi3D = figure(figOpt{:});
    otherwise
        posi3D = figure(Img.figOpt{:});
end

plot(Sim_Plot.SP_Posi(2,:),Sim_Plot.SP_Posi(1,:),'r','linewidth',2);hold on;axis equal
plot(Sim_Plot.X_Y_psi(2,:),Sim_Plot.X_Y_psi(1,:),'b','linewidth',2);
PlotBarcoFigura(XYpsi,Theta, PWM,F);

xlabel('Y (m)',Img.YLabelOpt{:});
ylabel('X (m)',Img.XLabelOpt{:});
legend(Leg.p3D{:},Img.Legend{:});

%% POSIÇÃO
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
if strcmp(Nome,'Circular')==0
    plot(TimeJ,Sim_Plot.SP_Posi(3,:)*RAD_TO_DEG,'r','linewidth',2); hold on;grid on;
    plot(TimeJ,Sim_Plot.X_Y_psi(3,:)*RAD_TO_DEG,'b','linewidth',2');
    legend(Leg.posicaoYaw3L{:},Img.Legend{:});
else
    plot(TimeJ,Sim_Plot.X_Y_psi(3,:)*RAD_TO_DEG,'b','linewidth',2');grid on;
    legend(Leg.posicaoYaw3L{1},Img.Legend{:});
end
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.yaw3L{:},Img.YLabelOpt{:});

linkaxes([ax1 ax2 ax3],'x')
xlim([0 TimeJ(end)])

%% VELOCIDADE
vel3L = figure(Img.figOpt3L{:});

vx1 = subplot(311);
plot(TimeJ,Sim_Plot.SP_Vel(1,:),'r','linewidth',2'); hold on; grid on;
plot(TimeJ,Sim_Plot.u_v_r(1,:),'b','linewidth',2');

legend(Leg.VelX3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YV3L{:},Img.YLabelOpt{:});

vx2 = subplot(312);
plot(TimeJ,Sim_Plot.SP_Vel(2,:),'r','linewidth',2'); hold on; grid on;
plot(TimeJ,Sim_Plot.u_v_r(2,:),'b','linewidth',2');
legend(Leg.VelY3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YV3L{:},Img.YLabelOpt{:});

vx3 = subplot(313);
plot(TimeJ,Sim_Plot.SP_Vel(3,:)*RAD_TO_DEG,'r','linewidth',2'); hold on; grid on;
plot(TimeJ,Sim_Plot.u_v_r(3,:)*RAD_TO_DEG,'b','linewidth',2');
legend(Leg.VelYaw3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YYaw3L{:},Img.YLabelOpt{:});

linkaxes([vx1 vx2 vx3],'x')

%% FORÇAS E ALOCAÇÃO
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

switch Nome
    case 'LinearX'
        figure(posi3D);
        axis([-15 15 -2 143]);
        ylim(ax1,[0 150]);
        ylim(ax2,[-15 15]);
        ylim(ax3,[-50 100]);
        legend(Leg.p3D{:},Img.Legend{:},'NumColumns',1,'Location','northoutside');
        
        figure(vel3L)
        ylim(vx1,[-0 4]);
        ylim(vx2,[-0 4]);
        ylim(vx3,[-20  20]);
        xlim([0 TimeJ(end)])
        
        figure(force)
        xlim(axf1,[0 TimeJ(end)])
        
    case 'Oito'
        figure(posi3D);
        
        ylim(ax1,[-60 5]);
        ylim(ax2,[-30 30]);
        ylim(ax3,[-50 250]);
        
        % velocidade
        ylim(vx2,[-.5 1])
        
    case 'Sway'
        figure(posi3D);
        axis([-2 70 -2 5]);
        
        figure(posi3L)
        ylim(ax1,[-1 60]);
        ylim(ax2,[0  70]);
        ylim(ax3,[-220  50]);
        xlim([0 TimeJ(end)])
        
        figure(vel3L)
        ylim(vx1,[-2 3]);
        ylim(vx2,[-2 3]);
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
        ylim(vx1,[-1 2.5]);
        ylim(vx2,[-1 2.5]);
        ylim(vx3,[-22.5 22.5]);
        xlim([0 TimeJ(end)])
        
    otherwise
end

if(salva==1)
    saveas(posi3D,strcat(Nome,'Posicao3D'),'epsc');
    saveas(posi3D,strcat(Nome,'Posicao3D'),'fig');
    
    saveas(posi3L,strcat(Nome,'Posicao3L'),'epsc');
    saveas(posi3L,strcat(Nome,'Posicao3L'),'fig');
    
    saveas(vel3L,strcat(Nome,'Velocidade3L'),'epsc');
    saveas(vel3L,strcat(Nome,'Velocidade3L'),'fig');
    
    saveas(force,strcat(Nome,'ForcaServo'),'epsc');
    saveas(force,strcat(Nome,'ForcaServo'),'fig');
    
end

end

