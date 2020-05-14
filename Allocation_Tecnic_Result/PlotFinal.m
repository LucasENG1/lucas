function PlotFinal(X,Y,Xmap,Ymap,F,F_out,theta,Pwm,md,md1,Nome)
global Fig;
% SINAL DO RC SEM SER MAPEADO
Fig = Fig+1;
figure(Fig)
subplot(211)
plot(X,'b','linewidth',2); ylabel('Fx');grid on
title(sprintf('Setpoints de Força: %s ',Nome));
ylim([-1.1 1.1])
subplot(212)
plot(Y,'b','linewidth',2); ylabel('Fy');grid on
ylim([-1.1 1.1])

%% SINAL DO RC MAPEADO
Fig = Fig+1;
figure(Fig)
subplot(211)
plot(Xmap,'r','linewidth',2); ylabel('X mapeado');grid on
title(sprintf('SINAL DO RC MAPEADO: %s ',Nome));
subplot(212)
plot(Ymap,'r','linewidth',2); ylabel('Y mapeado');grid on

%% SINAL DO RC MAPEADO
Fig = Fig+1;
figure(Fig)
subplot(121)
plot(X,Y,'-+b','linewidth',2);grid on; hold on
axis equal
axis([-1.1 1.1 -1.1 1.1])
subplot(122)
plot(Xmap,Ymap,'-+b','linewidth',2);
title(sprintf('SINAL DO RC MAPEADO X/Y: %s ',Nome));
axis equal
axis([-1.1 1.1 -1.1 1.1])
%% FORÇA DESEJADA e OBTIDA
Fig = Fig+1;
figure(Fig)
subplot(311)
plot(F(1,:) ,'b'); hold on; grid on
plot(F_out(1,:),'r');
legend('Desejado','Obtido');
xlabel('tempo');ylabel('Amplitude');
title(sprintf('FX: %s ',Nome));

subplot(312)
plot(F(2,:) ,'b'); hold on; grid on
plot(F_out(2,:),'r');
legend('Desejado','Obtido');
xlabel('tempo');ylabel('Amplitude');
title(sprintf('FY: %s ',Nome));

subplot(313)
plot(F(3,:) ,'b'); hold on; grid on
plot(F_out(3,:),'r');
legend('Desejado','Obtido');
xlabel('tempo');ylabel('Amplitude');
title(sprintf('TN: %s ',Nome));

%% MODULO DA FORÇA
Fig = Fig+1;
figure(Fig)
plot(md); hold on; grid on
plot(md1);
legend('Desejado','Obtido');
xlabel('X');ylabel('Y');
title(sprintf('Modulo: %s ',Nome));
% axis([0 90 0 50])
drawnow

%% ANGULOS
Fig = Fig+1;
figure(Fig)
subplot(411)
plot(theta(1,:));hold on;grid on;
title(sprintf('Angulo de Saida: %s ',Nome));
ylabel('Motor 1')

subplot(412)
plot(theta(2,:));hold on;grid on;
ylabel('Motor 2')

subplot(413)
plot(theta(3,:));hold on;grid on;
ylabel('Motor 3')

subplot(414)
plot(theta(4,:));hold on;grid on;
ylabel('Motor 4')

%% PWMs
Fig = Fig+1;
figure(Fig)
subplot(411)
plot(Pwm(1,:));hold on;grid on;
title(sprintf('PWM Saida: %s ',Nome));
ylabel('Motor 1')

subplot(412)
plot(Pwm(2,:));hold on;grid on;
ylabel('Motor 2')

subplot(413)
plot(Pwm(3,:));hold on;grid on;
ylabel('Motor 3')

subplot(414)
plot(Pwm(4,:));hold on;grid on;
ylabel('Motor 4')