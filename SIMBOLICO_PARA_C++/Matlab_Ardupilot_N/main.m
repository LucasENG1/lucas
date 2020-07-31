close all; clear all; clc

global Fmax Nmax k1 k2 k3 k4 M_PI DEG_TO_RAD RAD_TO_DEG L Lx Ly Pwmmax Pwmmin

%  Propriedade Física do Barco
M_PI = pi;
DEG_TO_RAD = (M_PI / 180.0);
RAD_TO_DEG = (180.0 / M_PI);

FM1 = 10*0.8;
FM2 = 10*2.6;
FM3 = 10*0.8;
FM4 = 10*2.6;

Fmax =  FM1 + FM2 + FM3 + FM4;

L  = 0.586;
Lx = L*cosf(M_PI/4.0);
Ly = L*cosf(M_PI/4.0);

Pwmmax = 1001.0;
Pwmmin = 1.0;
Nmax   = Fmax*L;

k1 = (FM1)/(Pwmmax-Pwmmin); %// Esse valor é atualizado no AduCopter.cpp para corresponder aos valores de memória
k2 = (FM2)/(Pwmmax-Pwmmin); %// Esse valor é atualizado no AduCopter.cpp para corresponder aos valores de memória
k3 = (FM3)/(Pwmmax-Pwmmin); %// Esse valor é atualizado no AduCopter.cpp para corresponder aos valores de memória
k4 = (FM4)/(Pwmmax-Pwmmin); %// Esse valor é atualizado no AduCopter.cpp para corresponder aos valores de memória


% SP
fx = [sind([1:1:360]) ,zeros(1,360)    ,zeros(1,360)    , 0.4*ones(1,360)   ];%,sind([1:2:600]),sind([1:2:600])];
fy = [zeros(1,360)    ,sind([1:1:360]) ,zeros(1,360)    , 0.1*ones(1,360)  ];%,cosd([1:2:600]),sind([1:2:600])];
tn = [zeros(1,360)    ,zeros(1,360)    ,sind([1:1:360]) , zeros(1,360)];%,zeros(1,300)   ,sind([1:2:600])];

PWM   = ones(4,1);
Theta = ones(4,1);
Erro  =  [];
F     =  [];

for i=1:length(fx)
%     i
    Fx(i) = 0.5*map(fx(i),fy(i))*Fmax;
    Fy(i) = 0.5*map(fy(i),fx(i))*Fmax;
    Tn(i) = 0.5*tn(i) * Nmax;
    
    [PWM(:,i+1),Theta(:,i+1),Erro(:,i),F(:,i)] = FOSSEN_alocation_matrix(Fx(i),Fy(i),Tn(i),PWM(:,i),Theta(:,i));
end
%%
figure(1)
plot(Fx(1,:),'linewidth',2);
hold on
plot(Fy(1,:),'linewidth',2);
plot(Tn(1,:),'linewidth',2);
legend('FX','FY','TN')
title('SETPOINTs');
hold off; grid on
%%
figure(2)
title('For�as Alocadas')
subplot(311)
plot(Fx(1,:),'b','linewidth',2)
title('FX')
hold on;
plot(F(1,:),'r','linewidth',2);
legend('Desejado','Obtido')
hold off; grid on

subplot(312)
plot(Fy(1,:),'b','linewidth',2);
title('FY')
hold on;
plot(F(2,:),'r','linewidth',2);
legend('Desejado','Obtido')
hold off; grid on

subplot(313)
plot(Tn(1,:),'b','linewidth',2);
title('TN')
hold on;
plot(F(3,:),'r','linewidth',2);
legend('Desejado','Obtido')
hold off; grid on

%%
figure(3)
subplot(411)
plot(PWM(1,:),'linewidth',2);
hold on
% plot(Pwmmax*ones(1,length(PWM(1,:))),'--k')
% plot(Pwmmin*ones(1,length(PWM(1,:))),'--k')
legend('PWM1'); grid on
hold off

subplot(412)
plot(PWM(2,:),'linewidth',2);
hold on
% plot(Pwmmax*ones(1,length(PWM(1,:))),'--k')
% plot(Pwmmin*ones(1,length(PWM(1,:))),'--k')
legend('PWM2'); grid on
hold off

subplot(413)
plot(PWM(3,:),'linewidth',2);
hold on
% plot(Pwmmax*ones(1,length(PWM(1,:))),'--k')
% plot(Pwmmin*ones(1,length(PWM(1,:))),'--k')
legend('PWM3'); grid on
hold off

subplot(414)
plot(PWM(4,:),'linewidth',2);
hold on
% plot(Pwmmax*ones(1,length(PWM(1,:))),'--k')
% plot(Pwmmin*ones(1,length(PWM(1,:))),'--k')
legend('PWM4'); grid on
hold off
%%
figure(4)
subplot(411)
plot(Theta(1,:)*RAD_TO_DEG,'linewidth',2);
legend('Theta1');grid on
subplot(412)
plot(Theta(2,:)*RAD_TO_DEG,'linewidth',2);
legend('Theta2');grid on
subplot(413)
plot(Theta(3,:)*RAD_TO_DEG,'linewidth',2);
legend('Theta3');grid on
subplot(414)
plot(Theta(4,:)*RAD_TO_DEG,'linewidth',2);
legend('Theta4');grid on
%%
figure(5)
subplot(311)
plot(Erro(1,:),'linewidth',2);
title('ERRO FX'); grid on
subplot(312)
plot(Erro(2,:),'linewidth',2);
title('ERRO FY'); grid on
subplot(313)
plot(Erro(3,:),'linewidth',2);
title('ERRO TN'); grid on

