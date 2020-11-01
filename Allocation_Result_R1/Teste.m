%[Th,PWM,Erro] = Allocation_FCA(F,Th,PWM)
close all; clear all; clc;

global Pwmmax Pwmmin APP k1 k2 k3 k4 M_PI Sim...
    DEG_TO_RAD RAD_TO_DEG Fmax L Lx Ly Nmax ;

%% Mantendo o padrão utilizado no C
M_PI = pi;
DEG_TO_RAD = pi/180;
RAD_TO_DEG = 180/pi;
Fmax = 0.86*9.81*4; % Força maxíma real
L    = 1;%0.586;
Nmax = L*Fmax;
Pwmmax = 1001.0;
Pwmmin = 1.0;
Lx = L*cos(M_PI/4.0);
Ly = L*cos(M_PI/4.0);
k1 = (Fmax/4.0)/(Pwmmax-Pwmmin);
k2 = k1;k3 = k1;k4 = k1;
%% Constante de Tempo
settling_time_mt  = 0.3;
settling_time_srv = 1.5;

tau_mt  = settling_time_mt/5;    % Motors
tau_srv = settling_time_srv/5;   % Servos

APP    = struct('tau_mt', tau_mt,'tau_srv',tau_srv);
Sim.Ts = 0.01;

%%
Time = 0:Sim.Ts:10;

F_desejado = [ 15.*cos(2*pi*0.1.*Time);...
       0.*sin(2*pi*1.*Time);...
       1.*sin(2*pi*0.1.*Time)];
   
Th = zeros(4,1);
PWM = zeros(4,1);
F_ot = zeros(3,1);
F_out = zeros(3,1);
Erro = zeros(3,1);
   
for i=2:length(F_desejado(1,:))
    [Th(:,i),PWM(:,i),Erro(:,i),F_out(:,i)] = Allocation_FCA(F_desejado,Th,PWM,i);

    
end
%% Força de saida
figure
ax(2) = subplot(311);
plot(Time,F_out(1,1:length(Time)),'b'); hold on
plot(Time,F_desejado(1,:),'r')
legend('Obtido','Desejado') ; title('Fx');axis tight
grid on
ax(1) = subplot(312);
plot(Time,F_out(2,1:length(Time)),'b'); hold on
plot(Time,F_desejado(2,:),'r');
legend('Obtido','Desejado') ; title('Fy');%axis tight
grid on
ax(3) = subplot(313);
plot(Time,F_out(3,1:length(Time)),'b'); hold on
plot(Time,F_desejado(3,:),'r')
legend('Obtido','Desejado') ; title('Yaw');axis tight
grid on

%% PWM de saida
figure
ax(1) = subplot(411);
plot(Time,PWM(1,1:length(Time)),'b','Parent',ax(1)); hold on
legend('Motor 1') ; title('PWM');axis tight
grid on

ax(2) = subplot(412);
plot(Time,PWM(2,1:length(Time)),'b','Parent',ax(2)); hold on
legend('Motor 2') ;axis tight
grid on

ax(3) = subplot(413);
plot(Time,PWM(3,1:length(Time)),'b','Parent',ax(3)); hold on
legend('Motor 3') ;axis tight
grid on

ax(4) = subplot(414);
plot(Time,PWM(4,1:length(Time)),'b','Parent',ax(4)); hold on
legend('Motor 4') ;axis tight
grid on
% linkaxes(ax,'xy')

%% Theta de saida
figure
ax(1) = subplot(411);
plot(Time,Th(1,1:length(Time))*(180/pi),'b','Parent',ax(1)); hold on
legend('Theta 1') ; title('Angulo');axis tight
grid on
ax(2) = subplot(412);
plot(Time,Th(2,1:length(Time))*(180/pi),'b','Parent',ax(2)); hold on
legend('Theta 2') ;axis tight
grid on
ax(3) = subplot(413);
plot(Time,Th(3,1:length(Time))*(180/pi),'b','Parent',ax(3)); hold on
legend('Theta 3') ;axis tight
grid on
ax(4) = subplot(414);
plot(Time,Th(4,1:length(Time))*(180/pi),'b','Parent',ax(4)); hold on
legend('Theta 4') ;axis tight
grid on
% linkaxes(ax,'xy')

%% Erro de saida de força
figure
ax(2) = subplot(311);
plot(Time,Erro(1,1:length(Time)),'b'); hold on
legend('X') ; title('Erro');axis tight
grid on

ax(1) = subplot(312);
plot(Time,Erro(2,1:length(Time)),'b'); hold on
legend('Y') ; title('Erro y');axis tight
grid on

ax(3) = subplot(313);
plot(Time,Erro(3,1:length(Time)),'b'); hold on
legend('Z') ; title('Erro Yaw');axis tight
grid on