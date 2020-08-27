function PlotSaidaReal(T,Theta,PWM,F,F_out,Nome,Language,salva)
%% PLOTA A FIGURA QUE CONTEM OS ANGULOS E OS PWMS DO SISTEMA

Img = ImageParametrization();% Opções de figura
Leg = LegendLanguage(Language);
global Fmax Nmax

%% ANGULOS
Th1  = Theta(1,:); Th2 = Theta(2,:); Th3 = Theta(3,:); Th4 = Theta(4,:);
pwm1 = PWM(1,:)  ; pwm2 = PWM(2,:) ; pwm3 = PWM(3,:) ; pwm4 = PWM(4,:);

servoAngle = figure(Img.figOpt4L{:});

axSa1 = subplot(411);
plot(T,Th1,'b','linewidth',2);hold on; grid on;
legend(Leg.ServoAngle1{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});

axSa2 = subplot(412);
plot(T,Th2,'b','linewidth',2);hold on; grid on;
legend(Leg.ServoAngle2{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});

axSa3 = subplot(413);
plot(T,Th3,'b','linewidth',2);hold on; grid on;
legend(Leg.ServoAngle3{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});

axSa4 = subplot(414);
plot(T,Th4,'b','linewidth',2);hold on; grid on;
legend(Leg.ServoAngle4{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});

linkaxes([axSa1 axSa2 axSa3 axSa4],'xy')
xlim([0 T(end)])

%% PWM
servoPwm = figure(Img.figOpt4L{:});

axPa1 = subplot(411);
plot(T,pwm1,'b','linewidth',2);hold on; grid on;
legend(Leg.ServoPWM1{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

axPa2 = subplot(412);
plot(T,pwm2,'b','linewidth',2);hold on; grid on;
legend(Leg.ServoPWM2{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

axPa3 = subplot(413);
plot(T,pwm3,'b','linewidth',2);hold on; grid on;
legend(Leg.ServoPWM3{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

axPa4 = subplot(414);
plot(T,pwm4,'b','linewidth',2);hold on; grid on;
legend(Leg.ServoPWM4{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

linkaxes([axPa1 axPa2 axPa3 axPa4],'xy')

xlim([0 T(end)]);

ylim([0 1]);

%% Força
force =figure(Img.figOpt3L{:});
ax12=subplot(311);
plot(T,F(1,:).*Fmax,'linewidth',2); hold on
plot(T,F_out(1,:),'linewidth',2);
grid on;
legend(Leg.AlocacaoX{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Forca{:},Img.YLabelOpt{:});

ax22=subplot(312);
plot(T,F(2,:).*Fmax,'linewidth',2); hold on
plot(T,F_out(2,:),'linewidth',2);
grid on;
legend(Leg.AlocacaoY{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Forca{:},Img.YLabelOpt{:});

ax32=subplot(313);
plot(T,F(3,:).*Nmax,'linewidth',2); hold on
plot(T,F_out(3,:),'linewidth',2);
grid on;
legend(Leg.AlocacaoPsi{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.Torque{:},Img.YLabelOpt{:});
linkaxes([ax12 ax22 ax32],'x');
xlim([0 T(end)])

if(salva==1)
    saveas(servoAngle,strcat('BOM/',strcat(Nome,'Ang_Servo')),'epsc');
    saveas(servoAngle,strcat('BOM/',strcat(Nome,'Ang_Servo')),'fig');
    
    saveas(servoPwm,strcat('BOM/',strcat(Nome,'PWM_Servo')),'epsc');
    saveas(servoPwm,strcat('BOM/',strcat(Nome,'PWM_Servo')),'fig');
    
    saveas(force,strcat('BOM/',strcat(Nome,'ForcaServo')),'epsc');
    saveas(force,strcat('BOM/',strcat(Nome,'ForcaServo')),'fig');
    
end
end