function PlotSaidaReal(T2,Theta,PWM,F,F_out,Nome,Language,salva)
%% PLOTA A FIGURA QUE CONTEM OS ANGULOS E OS PWMS DO SISTEMA

Img = ImageParametrization();% Opções de figura
Leg = LegendLanguage(Language);
global Fmax Nmax

%% ANGULOS
Th1  = Theta(1,:); Th2 = Theta(2,:); Th3 = Theta(3,:); Th4 = Theta(4,:);
pwm1 = PWM(1,:)  ; pwm2 = PWM(2,:) ; pwm3 = PWM(3,:) ; pwm4 = PWM(4,:);

servoAngle = figure(Img.figOpt2L{:});

% axSa1 = subplot(411);
plot(T2,Th1,'b--','linewidth',2);hold on; grid on;
% legend(Leg.ServoAngle1{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% axSa2 = subplot(412);
plot(T2,Th2,'r','linewidth',2);hold on; grid on;
% legend(Leg.ServoAngle2{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YSA{:},Img.YLabelOpt{:});

% axSa3 = subplot(413);
plot(T2,Th3,'g--','linewidth',2);hold on; grid on;
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
ylim([-180 180])    
xlim([0 T2(end)])

%% PWM
servoPwm = figure(Img.figOpt2L{:});

% axPa1 = subplot(411);
plot(T2,pwm1,'b--','linewidth',2);hold on; grid on;
% legend(Leg.ServoPWM1{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% axPa2 = subplot(412);
plot(T2,pwm2,'r','linewidth',2);hold on; grid on;
% legend(Leg.ServoPWM2{:},Img.Legend{:});
% xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
% ylabel(Leg.YPWM{:},Img.YLabelOpt{:});

% axPa3 = subplot(413);
plot(T2,pwm3,'g--','linewidth',2);hold on; grid on;
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

if(salva==1)
    saveas(servoAngle,strcat('Figuras/',strcat(Nome,'Ang_Servo')),'epsc');
    saveas(servoAngle,strcat('Figuras/',strcat(Nome,'Ang_Servo')),'fig');
    
    saveas(servoPwm,strcat('Figuras/',strcat(Nome,'PWM_Servo')),'epsc');
    saveas(servoPwm,strcat('Figuras/',strcat(Nome,'PWM_Servo')),'fig');
    
    saveas(force,strcat('Figuras/',strcat(Nome,'ForcaServo')),'epsc');
    saveas(force,strcat('Figuras/',strcat(Nome,'ForcaServo')),'fig');
    
end
end