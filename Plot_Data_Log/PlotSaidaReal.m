function PlotSaidaReal(T,Theta,PWM,F,F_out,Nome,salva)
%% PLOTA A FIGURA QUE CONTEM OS ANGULOS E OS PWMS DO SISTEMA

Img = ImageParametrization();% Opções de figura
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
legend('Servo-motor M1','Servo-motor M2',...
'Servo-motor M3','Servo-motor M4',...
Img.Legend{:} ,'Location','best');
xlabel('Tempo (s)',Img.XLabelOpt{:});
ylabel('$Graus$',Img.YLabelOpt{:});
grid on

%% PWM
axb = subplot(212);
plot(T,pwm1,'linewidth',2); hold on
plot(T,pwm2,'linewidth',2);
plot(T,pwm3,'linewidth',2);
plot(T,pwm4,'linewidth',2);
% title('PWM',Img.TlabelOpt{:});
legend('PWM M1','PWM M2','PWM M3','PWM M4',...
Img.Legend{:},'Location','best'); grid on
xlabel('Tempo (s)',Img.XLabelOpt{:});
ylabel('Porcentagem',Img.YLabelOpt{:});
grid on
linkaxes([axa axb],'x')
xlim([0 T(end)])

%% Força
force =figure(Img.figOpt3L{:});
ax12=subplot(311);
plot(T,F(1,:).*Fmax,'linewidth',2); hold on
plot(T,F_out(1,:),'linewidth',2);
% title('',Img.TlabelOpt{:});
legend('$F_x$ a alocar','$F_x$ alocado',Img.Legend{:},'Location','best');grid on
xlabel('Tempo (s)',Img.XLabelOpt{:});
ylabel('Newton',Img.YLabelOpt{:});

ax22=subplot(312);
plot(T,F(2,:).*Fmax,'linewidth',2); hold on
plot(T,F_out(2,:),'linewidth',2);
% title('$F_y$',Img.TlabelOpt{:});
legend('$F_y$ a alocar','$F_y$ alocado',Img.Legend{:},'Location','best');grid on
xlabel('Tempo (s)',Img.XLabelOpt{:});
ylabel('Newton',Img.YLabelOpt{:});

ax32=subplot(313);
plot(T,F(3,:).*Nmax,'linewidth',2); hold on
plot(T,F_out(3,:),'linewidth',2);
% title('$\tau_{\psi}$',Img.TlabelOpt{:});
legend('$\tau_{\psi}$ a alocar','$\tau_{\psi} $ alocado',...
Img.Legend{:},'Location','best');grid on
xlabel('Tempo (s)',Img.XLabelOpt{:});
ylabel('N.m',Img.YLabelOpt{:});

linkaxes([ax12 ax22 ax32],'x');
xlim([0 T(end)])

if(salva==1)
    saveas(ang,strcat(Nome,'Ang_PWM_Servo'),'epsc');
    saveas(ang,strcat(Nome,'Ang_PWM_Servo'),'fig');
    
    saveas(force,strcat(Nome,'ForcaServo'),'epsc');
    saveas(force,strcat(Nome,'ForcaServo'),'fig');
    
end
end