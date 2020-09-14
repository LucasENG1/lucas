function PlotCenarioReal(Nboats,T1,T2,T3,Pose_real,Vel_real,Theta,PWM,F,F_out,Nome,Language,salva)
global Fmax Nmax;

Img = ImageParametrization();
Leg = LegendLanguage(Language);

passo = floor(length(Pose_real(1,:))/Nboats); % Passo para plotar o Barco
XYpsi = Pose_real(:,1:passo:end);

F1     = 0*XYpsi;%F(:,1:passo:end)/5;
Theta1 = zeros(4,length(XYpsi(1,:)));
PWM1   = zeros(4,length(XYpsi(1,:)));

%% POSIÇÃO 3D
switch Nome
    case 'Cenario1'
        Screen = [0 0 .5 1];
        figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto','Position',Screen};
        posi3D = figure(figOpt{:});
        
        Pose_real(3,:) = Pose_real(3,:) +pi/2;
        XYpsi = Pose_real(:,1:passo:end);
        Ax = Pose_real(2,:);
        Pose_real(2,:)= Pose_real(1,:);
        Pose_real(1,:) = Ax;
        
        plot(Pose_real(1,:),Pose_real(2,:),'color',Img.COR,'linewidth',2); hold on;
        PlotBarcoFigura(XYpsi,Theta1,PWM1,F1);
        
        Ax = Pose_real(2,:);
        Pose_real(2,:)= Pose_real(1,:);
        Pose_real(1,:) = Ax;
        Pose_real(3,:) = Pose_real(3,:) - pi/2;
        
    otherwise
        
        Ax        = XYpsi(2,:);
        XYpsi(2,:)= XYpsi(1,:);
        XYpsi(1,:) = Ax;
        
        posi3D = figure(Img.figOpt{:});
        plot(Pose_real(1,:),Pose_real(2,:),'color',Img.COR,'linewidth',2);  hold on;
        PlotBarcoFigura(XYpsi,Theta1,PWM1,F1);
end

xlabel('Y (m)',Img.YLabelOpt{:});
ylabel('X (m)',Img.YLabelOpt{:});
legend(Leg.p3D2{1},Img.Legend{:});

%% POSIÇÃO EM CADA COMPONENTE
posi3L=figure(Img.figOpt3L{:});
ax1 = subplot(311);
% plot(SP.t,SP.Y,'r','linewidth',2);hold on
plot(T1,Pose_real(2,:),'color',Img.COR,'linewidth',2);grid on
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YP3L{:},Img.YLabelOpt{:});
legend('$X$ position',Img.Legend{:});

ax2 = subplot(312);
% plot(SP.t,SP.X,'r','linewidth',2);hold on
plot(T1,Pose_real(1,:),'color',Img.COR,'linewidth',2);grid on
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YP3L{:},Img.YLabelOpt{:});
legend('$Y$ position',Img.Legend{:});

ax3 = subplot(313);
% plot(SP.t,SP.Yaw*RAD_TO_DEG,'r','linewidth',2);hold on;
plot(T1,Pose_real(3,:)*(180/pi),'color',Img.COR,'linewidth',2);grid on
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.yaw3L{:},Img.YLabelOpt{:});
legend('$\psi$ position',Img.Legend{:});

linkaxes([ax1 ax2 ax3],'x')
xlim([0 T1(end)])

%%  VELOCIDADE
vel3L=figure(Img.figOpt2L{:});
vx1 = subplot(211);
plot(T3,Vel_real(1,:),'linewidth',2);hold on;grid on;
plot(T3,Vel_real(2,:),'linewidth',2);
legend(Leg.VelXY{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YV3L{:},Img.YLabelOpt{:});

vx3 = subplot(212);
plot(T3,Vel_real(3,:),'b','linewidth',2);grid on;
legend(Leg.VelYaw{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YYaw3L{:},Img.YLabelOpt{:});

linkaxes([vx1 vx3],'x')
xlim([0 T3(end)])

%% Força
force =figure(Img.figOpt3L{:});
ax12=subplot(311);
plot(T2,F(1,:).*Fmax,'linewidth',2); hold on;grid on;
plot(T2,F_out(1,:),'linewidth',2);
legend(Leg.AlocacaoX{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Forca{:},Img.YLabelOpt{:});

ax22=subplot(312);
plot(T2,F(2,:).*Fmax,'linewidth',2); hold on;grid on;
plot(T2,F_out(2,:),'linewidth',2);
legend(Leg.AlocacaoY{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Forca{:},Img.YLabelOpt{:});

ax32=subplot(313);
plot(T2,F(3,:).*Nmax,'linewidth',2); hold on;grid on;
plot(T2,F_out(3,:),'linewidth',2);
legend(Leg.AlocacaoPsi{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Torque{:},Img.YLabelOpt{:});

linkaxes([ax12 ax22 ax32],'x');
xlim([0 T2(end)])

%% ANGULOS
Th1  = Theta(1,:); Th2 = Theta(2,:); Th3 = Theta(3,:); Th4 = Theta(4,:);
pwm1 = PWM(1,:)  ; pwm2 = PWM(2,:) ; pwm3 = PWM(3,:) ; pwm4 = PWM(4,:);

servoAngle = figure(Img.figOpt1L{:});

plot(T2,Th1,'b','linewidth',2);hold on; grid on;
plot(T2,Th2,'r','linewidth',2);hold on; grid on;
plot(T2,Th3,'g','linewidth',2);hold on; grid on;
plot(T2,Th4,'m','linewidth',2);hold on; grid on;

legend(Leg.ServoAngle{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});

xlim([0 T2(end)])

%% PWM
servoPwm = figure(Img.figOpt1L{:});

% axPa1 = subplot(411);
plot(T2,pwm1,'b','linewidth',2);hold on; grid on;
plot(T2,pwm2,'r','linewidth',2);hold on; grid on;
plot(T2,pwm3,'g','linewidth',2);hold on; grid on;
plot(T2,pwm4,'m','linewidth',2);hold on; grid on;

legend(Leg.ServoPWM{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

xlim([0 T2(end)]);
ylim([0 1]);

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
        xlim(vx1,[0 T3(end)]);
        subplot(211)
        legend(Leg.VelXY{:},Img.Legend{:},'NumColumns',2,'Location','northeast');
        
        
        figure(servoAngle)
        ylim([-180 180]);
        xlim(vx1,[0 T1(end)]);
        
    case 'Cenario2'
        figure(posi3D);
        %         axis([-17.5 17.5 -2.5 35]);
        legend(Leg.p3D{:},Img.Legend{:},'NumColumns',2,'Location','north');
        
        figure(vel3L)
        ylim(vx1,[-0.6 2]);
        xlim(vx1,[0 T3(end)]);
        subplot(211)
        legend(Leg.VelXY{:},Img.Legend{:},'NumColumns',2,'Location','northeast');
        
        subplot(212)
        legend(Leg.VelYaw{:},Img.Legend{:},'Location','southeast');
        
    case 'Cenario3'
        figure(posi3D);
        axis([-2 32 -2 35]);
        legend(Leg.p3D2{:},Img.Legend{:},'NumColumns',2,'Location','north');
        
        figure(vel3L)
        ylim(vx1,[-1.2 1.2]);
        xlim(vx1,[0 T3(end)]);
        subplot(211)
        legend(Leg.VelXY{:},Img.Legend{:},'NumColumns',2,'Location','northeast');
        
    case  'ComparaFinal3dof'
        
        figure(force)
        xlim([0 82.5])
        
        figure(servoPwm)
        xlim([0 82.5])
        
        figure(servoAngle)
        xlim([0 82.5])
        
        figure(vel3L)
        xlim([0 82.5])
        
    case  'ComparaFinal2dof'
        
        figure(force)
        xlim([0 85])
        
        figure(servoPwm)
        xlim([0 85])
        
        figure(servoAngle)
        xlim([0 85])
        
        figure(vel3L)
        xlim([0 85])
    otherwise
end


if(salva==1)
    %     saveas(posi3D,strcat('Figuras_EPS/',strcat(Nome,'Posicao3D')),'epsc');
    %     saveas(posi3D,strcat('Figuras_FIG/',strcat(Nome,'Posicao3D')),'fig');
    
    saveas(posi3L,strcat('Real_EPS_output/',strcat(Nome,'Posicao3L')),'epsc');
    saveas(posi3L,strcat('Real_FIG_output/',strcat(Nome,'Posicao3L')),'fig');
    
    saveas(vel3L,strcat('Real_EPS_output/',strcat(Nome,'Velocidade2L')),'epsc');
    saveas(vel3L,strcat('Real_FIG_output/',strcat(Nome,'Velocidade2L')),'fig');
    
    saveas(servoAngle,strcat('Real_EPS_output/',strcat(Nome,'Angle')),'epsc');
    saveas(servoAngle,strcat('Real_FIG_output/',strcat(Nome,'Angle')),'fig');
    
    saveas(servoPwm,strcat('Real_EPS_output/',strcat(Nome,'PWM')),'epsc');
    saveas(servoPwm,strcat('Real_FIG_output/',strcat(Nome,'PWM')),'fig');
    
    saveas(force,strcat('Real_EPS_output/',strcat(Nome,'Forca')),'epsc');
    saveas(force,strcat('Real_FIG_output/',strcat(Nome,'Forca')),'fig');
end


