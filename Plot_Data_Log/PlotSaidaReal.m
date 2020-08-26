function PlotSaidaReal(T,Theta,PWM,F,F_out,Nome,Language,salva)
%% PLOTA A FIGURA QUE CONTEM OS ANGULOS E OS PWMS DO SISTEMA

Img = ImageParametrization();% Opções de figura
Leg = LegendLanguage(Language);
global Fmax Nmax

%% ANGULOS
Th1  = Theta(1,:); Th2 = Theta(2,:); Th3 = Theta(3,:); Th4 = Theta(4,:);
pwm1 = PWM(1,:)  ; pwm2 = PWM(2,:) ; pwm3 = PWM(3,:) ; pwm4 = PWM(4,:);

ang = figure(Img.figOpt3L{:});
axa = subplot(211);
plot(T,Th1,'linewidth',2); hold on
plot(T,Th2,'linewidth',2);
plot(T,Th3,'linewidth',2);
plot(T,Th4,'linewidth',2);
% title('Angulo dos Servo-motores',Img.TlabelOpt{:});
% legend('Servo-motor M1','Servo-motor M2','Servo-motor M3','Servo-motor M4',Img.Legend{:} ,'Location','best');

legend(Leg.ServoAngle{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YSA{:},Img.YLabelOpt{:});

grid on

%% PWM
axb = subplot(212);
plot(T,pwm1,'linewidth',2); hold on
plot(T,pwm2,'linewidth',2);
plot(T,pwm3,'linewidth',2);
plot(T,pwm4,'linewidth',2);

legend(Leg.ServoPWM{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YPWM{:},Img.YLabelOpt{:});
grid on
linkaxes([axa axb],'x')
xlim([0 T(end)])

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
    saveas(ang,strcat(Nome,'Ang_PWM_Servo'),'epsc');
    saveas(ang,strcat(Nome,'Ang_PWM_Servo'),'fig');
    
    saveas(force,strcat(Nome,'ForcaServo'),'epsc');
    saveas(force,strcat(Nome,'ForcaServo'),'fig');
    
end
end