function PlotCenarioReal(T1,T2,T3,Pose_real,Vel_real,Theta,PWM,F,F_out,Nome,Language,salva)
global  RAD_TO_DEG Fmax Nmax;

Img = ImageParametrization();
Leg = LegendLanguage(Language);

%% POSIÇÃO 3D
switch Nome
    case 'Linear_Real'
        Screen = [0 0 0.5 0.5];
        figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto',...
            'Position',Screen};
        posi3D = figure(figOpt{:});
        Ax = Pose_real(2,:);
        Pose_real(2,:)= Pose_real(1,:);
        Pose_real(1,:) = Ax;
        Pose_real(3,:) = Pose_real(3,:) +pi/2;
        
%         plot(SP.Y,SP.X,'r','linewidth',2);hold on;axis equal
        plot(Pose_real(1,:),Pose_real(2,:),'color',Img.COR,'linewidth',2)
        FiguraArtigo(20,Pose_real); grid on;
        
        Ax = Pose_real(2,:);
        Pose_real(2,:)= Pose_real(1,:);
        Pose_real(1,:) = Ax;
        Pose_real(3,:) = Pose_real(3,:) - pi/2;
        
    otherwise
        posi3D = figure(Img.figOpt{:});
        plot(Pose_real(1,:),Pose_real(2,:),'color',Img.COR,'linewidth',2)
        FiguraArtigo(20,Pose_real); grid on;
end


xlabel('Y (m)',Img.YLabelOpt{:});
ylabel('X (m)',Img.YLabelOpt{:});
legend(Leg.p3D{:},Img.Legend{:});

%% POSIÇÃO EM CADA COMPONENTE
posi3L=figure(Img.figOpt3L{:});
ax1 = subplot(311);
% plot(SP.t,SP.Y,'r','linewidth',2);hold on
plot(T1,Pose_real(2,:),'color',Img.COR,'linewidth',2);grid on
legend('$X$ position',Img.Legend{:});  
%legend(Leg.posicaoX3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YP3L{:},Img.YLabelOpt{:});

ax2 = subplot(312);
% plot(SP.t,SP.X,'r','linewidth',2);hold on
plot(T1,Pose_real(1,:),'color',Img.COR,'linewidth',2);grid on
legend('$Y$ position',Img.Legend{:});  
%legend(Leg.posicaoY3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YP3L{:},Img.YLabelOpt{:});

ax3 = subplot(313);
% plot(SP.t,SP.Yaw*RAD_TO_DEG,'r','linewidth',2);hold on;
plot(T1,Pose_real(3,:)*RAD_TO_DEG,'color',Img.COR,'linewidth',2);grid on
legend('$\psi$ position',Img.Legend{:});  
% legend(Leg.posicaoYaw3L{1},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.yaw3L{:},Img.YLabelOpt{:});

linkaxes([ax1 ax2 ax3],'x')
xlim([0 T1(end)])

%%  VELOCIDADE
vel3L=figure(Img.figOpt2L{:});
vx1 = subplot(211);
plot(T3,Vel_real(1,:),'linewidth',2);hold on;grid on
% legend(Leg.VelX3L{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YV3L{:},Img.YLabelOpt{:});

% vx2 = subplot(312);
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

%% ANGULOS
Th1  = Theta(1,:); Th2 = Theta(2,:); Th3 = Theta(3,:); Th4 = Theta(4,:);
pwm1 = PWM(1,:)  ; pwm2 = PWM(2,:) ; pwm3 = PWM(3,:) ; pwm4 = PWM(4,:);

servoAngle = figure(Img.figOpt1L{:});

% axSa1 = subplot(411);
plot(T2,Th1,'b','linewidth',2);hold on; grid on;
% legend(Leg.ServoAngle1{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% axSa2 = subplot(412);
plot(T2,Th2,'r','linewidth',2);hold on; grid on;
% legend(Leg.ServoAngle2{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% axSa3 = subplot(413);
plot(T2,Th3,'g','linewidth',2);hold on; grid on;
% legend(Leg.ServoAngle3{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% axSa4 = subplot(414);
plot(T2,Th4,'m','linewidth',2);hold on; grid on;
% legend(Leg.ServoAngle4{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

legend(Leg.ServoAngle{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});
% linkaxes([axSa1 axSa2 axSa3 axSa4],'xy')
% ylim([-180 90])    
xlim([0 T2(end)])

%% PWM
servoPwm = figure(Img.figOpt1L{:});

% axPa1 = subplot(411);
plot(T2,pwm1,'b','linewidth',2);hold on; grid on;
% legend(Leg.ServoPWM1{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% axPa2 = subplot(412);
plot(T2,pwm2,'r','linewidth',2);hold on; grid on;
% legend(Leg.ServoPWM2{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% axPa3 = subplot(413);
plot(T2,pwm3,'g','linewidth',2);hold on; grid on;
% legend(Leg.ServoPWM3{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% axPa4 = subplot(414);
plot(T2,pwm4,'m','linewidth',2);hold on; grid on;
% legend(Leg.ServoPWM4{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% linkaxes([axPa1 axPa2 axPa3 axPa4],'xy')

legend(Leg.ServoPWM{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

xlim([0 T2(end)]);
ylim([0 1]);

%% Força
force =figure(Img.figOpt3L{:});
ax12=subplot(311);
plot(T2,F(1,:).*Fmax,'linewidth',2); hold on
plot(T2,F_out(1,:),'linewidth',2);
grid on;
legend(Leg.AlocacaoX{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Forca{:},Img.YLabelOpt{:});

ax22=subplot(312);
plot(T2,F(2,:).*Fmax,'linewidth',2); hold on
plot(T2,F_out(2,:),'linewidth',2);
grid on;
legend(Leg.AlocacaoY{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Forca{:},Img.YLabelOpt{:});

ax32=subplot(313);
plot(T2,F(3,:).*Nmax,'linewidth',2); hold on
plot(T2,F_out(3,:),'linewidth',2);
grid on;
legend(Leg.AlocacaoPsi{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Torque{:},Img.YLabelOpt{:});
linkaxes([ax12 ax22 ax32],'x');
xlim([0 T2(end)])

switch Nome
    case 'Linear_Real'
        figure(posi3D);
        axis([ -2 143 -10 10]);
        % posição
        ylim(ax1,[0 150]);
        ylim(ax2,[-15 15]);
        ylim(ax3,[-50 100]);
        legend(Leg.p3D{:},Img.Legend{:},'NumColumns',2,'Location','northoutside');
        xlabel('X (m)',Img.YLabelOpt{:});
        ylabel('Y (m)',Img.YLabelOpt{:});
        
        figure(vel3L)
        ylim(vx1,[-0 4]);
%         ylim(vx3,[-20  25]);
        xlim([0 T1(end)])
end


if(salva==1)
%     saveas(posi3D,strcat('Figuras/',strcat(Nome,'Posicao3D')),'epsc');
%     saveas(posi3D,strcat('Figuras/',strcat(Nome,'Posicao3D')),'fig');
    
    saveas(posi3L,strcat('Figuras/',strcat(Nome,'Posicao3L')),'epsc');
    saveas(posi3L,strcat('Figuras/',strcat(Nome,'Posicao3L')),'fig');
    
    saveas(vel3L,strcat('Figuras/',strcat(Nome,'Velocidade3L')),'epsc');
    saveas(vel3L,strcat('Figuras/',strcat(Nome,'Velocidade3L')),'fig');
    
    saveas(servoAngle,strcat('Figuras/',strcat(Nome,'Ang_Servo')),'epsc');
    saveas(servoAngle,strcat('Figuras/',strcat(Nome,'Ang_Servo')),'fig');
    
    saveas(servoPwm,strcat('Figuras/',strcat(Nome,'PWM_Servo')),'epsc');
    saveas(servoPwm,strcat('Figuras/',strcat(Nome,'PWM_Servo')),'fig');
    
    saveas(force,strcat('Figuras/',strcat(Nome,'ForcaServo')),'epsc');
    saveas(force,strcat('Figuras/',strcat(Nome,'ForcaServo')),'fig');
end


