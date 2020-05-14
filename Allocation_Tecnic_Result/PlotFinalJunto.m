function PlotFinalJunto(X,Y,Xmap,Ymap,F,F_out,theta,Pwm,md,md1,Nome,F_out1,theta1,Pwm1,md2,Nome1)
global Fig;
%% SINAL DO RC SEM SER MAPEADO
% Fig = Fig+1;
% figure(Fig)
% subplot(211)
% plot(X); ylabel('X');grid on
% title(sprintf('SINAL DO RC SEM SER MAPEADO: %s ',Nome));
% subplot(212)
% plot(Y); ylabel('Y');grid on

% %% SINAL DO RC MAPEADO
% Fig = Fig+1;
% figure(Fig)
% subplot(211)
% plot(Xmap); ylabel('X maped');grid on
% title(sprintf('SINAL DO RC MAPEADO: %s ',Nome));
% subplot(212)
% plot(Ymap); ylabel('Y maped');grid on

% %% SINAL DO RC MAPEADO
% Fig = Fig+1;
% figure(Fig)
% plot(X,Y);grid on; hold on
% plot(Xmap,Ymap);
% title(sprintf('SINAL DO RC MAPEADO X/Y: %s ',Nome));
% axis equal

%% FORÇA DESEJADA e OBTIDA
Fig = Fig+1;
figure(Fig)
subplot(311)
plot(F(1,:) ,'b'); hold on; grid on
plot(F_out(1,:),'r');
plot(F_out1(1,:),'g');
legend('Desejado','Murillo','Fossen');
xlabel('tempo');ylabel('Amplitude');
title(sprintf('FX: %s ',Nome));

subplot(312)
plot(F(2,:) ,'b'); hold on; grid on
plot(F_out(2,:),'r');
plot(F_out1(2,:),'g');
legend('Desejado','Murillo','Fossen');
xlabel('tempo');ylabel('Amplitude');
title(sprintf('FY: %s ',Nome));

subplot(313)
plot(F(3,:) ,'b'); hold on; grid on
plot(F_out(3,:),'r');
plot(F_out1(3,:),'g');
legend('Desejado','Murillo','Fossen');
xlabel('tempo');ylabel('Amplitude');
title(sprintf('TN: %s ',Nome));

%% MODULO DA FORÇA
Fig = Fig+1;
figure(Fig)
plot(md,'b'); hold on; grid on
plot(md1,'r');
plot(md2,'g');
legend('Desejado','Murillo','Fossen');
xlabel('X');ylabel('Y');
title(sprintf('Modulo: %s ',Nome));
% axis([0 90 0 50])
drawnow

%% ANGULOS
Fig = Fig+1;
figure(Fig)
subplot(411)
plot(theta(1,:),'r');hold on;grid on;
plot(theta1(1,:),'g');
title(sprintf('Angulo de Saida: %s ',Nome));
ylabel('Motor 1')
legend('Murillo','Fossen')

subplot(412)
plot(theta(2,:),'r');hold on;grid on;
plot(theta1(2,:),'g');
ylabel('Motor 2')
legend('Murillo','Fossen')

subplot(413)
plot(theta(3,:),'r');hold on;grid on;
plot(theta1(3,:),'g');
ylabel('Motor 3')
legend('Murillo','Fossen')

subplot(414)
plot(theta(4,:),'r');hold on;grid on;
plot(theta1(4,:),'g');
ylabel('Motor 4')
legend('Murillo','Fossen')

%% PWMs
Fig = Fig+1;
figure(Fig)
subplot(411)
plot(Pwm(1,:),'r');hold on;grid on;
plot(Pwm1(1,:),'g');
title(sprintf('PWM Saida: %s ',Nome));
ylabel('Motor 1')
legend('Murillo','Fossen')

subplot(412)
plot(Pwm(2,:),'r');hold on;grid on;
plot(Pwm1(2,:),'g');
ylabel('Motor 2')
legend('Murillo','Fossen')

subplot(413)
plot(Pwm(3,:),'r');hold on;grid on;
plot(Pwm1(3,:),'g');
ylabel('Motor 3')
legend('Murillo','Fossen')

subplot(414)
plot(Pwm(4,:),'r');hold on;grid on;
plot(Pwm(4,:),'g');
ylabel('Motor 4')
legend('Murillo','Fossen')