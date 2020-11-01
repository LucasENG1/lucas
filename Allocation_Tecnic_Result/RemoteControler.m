clear all; close all; clc
global Pwmmax Pwmmin k1 k2 k3 k4 M_PI DEG_TO_RAD RAD_TO_DEG Fmax L Lx Ly Nmax APP Fig Sim;

%% Mantendo o padrão utilizado no C
M_PI = pi;
DEG_TO_RAD = pi/180;
RAD_TO_DEG = 180/pi;
Fmax = 1;%0.86*9.81*4; % Força maxíma real
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

%% >>>>>>>>>>>>>>>  Emulando o uso do controle remoto
% vetor para construir um quadrado unitário
salva = 0;

N = {'Cenario1','Cenario2','Cenario3','Cenario4','Torque'}; 
Nome = N{1};

switch Nome
    case 'Cenario2'
        ft = 1;
    otherwise
        ft = 1;
end

[X,Y,TN] = Setpoint(Nome,ft);

plt   = 0;
passo = 10;

F_out = [];
theta = [0;0;0;0];
Pwm   = [0;0;0;0];

Fig =1;
for i=1:length(X)
    % Mapeamento
    Xmap(i)  = mapcube(X(i),Y(i),TN(i));
    Ymap(i)  = mapcube(Y(i),X(i),TN(i));
    TNmap(i) = mapcube(TN(i),X(i),Y(i));

    % SP mapeado
    F(:,i) = [Xmap(i);Ymap(i);TNmap(i)];
    
    %% matriz de alocação
    [theta(:,i+1),Pwm(:,i+1)] = Allocation_Artigo1_M13_24_PWM_igual(F(:,i),theta,Pwm,i);
    
    %% alocação direta para conferir
    F_out(:,i)  = Aloc_Direta(theta(:,i+1),Pwm(:,i+1));
    
    %% indices desempenho
     md(i)  = norm([F(1,i)*Fmax,F(2,i)*Fmax,F(3,i)*Nmax]');
     md1(i) = norm(F_out(:,i));
    
    %% plot barco
    if(mod(i,passo)==0 && plt == 1)
        figure(Fig)
        subplot(3,5,[1 2])
        hold on;
        plot(Ymap(i),Xmap(i),'.r');
        axis equal; grid on;axis([-1 1 -1 1]);
        hold off;
        
        subplot(3,5,[6 7 11 12])
        Plot_general(theta.*DEG_TO_RAD,Pwm,i);
        
        subplot(3,5,[3 4 5]);hold on
        plot(i,F(1,i).*Fmax ,'ob'); hold on; grid on
        plot(i,F_out(1,i),'+r');
        legend('Desejado','Obtido');
        xlabel('tempo');ylabel('Amplitude');
        title('FX'); axis([0 length(X) -35 35])
        
        subplot(3,5,[8 9 10]);hold on
        plot(i,F(2,i).*Fmax ,'ob'); hold on; grid on
        plot(i,F_out(2,i),'+r');
        legend('Desejado','Obtido');
        xlabel('tempo');ylabel('Amplitude');
        title('FY'); axis([0 length(X) -35 35])
        
        subplot(3,5,[13 14 15]);hold on
        plot(i,F(3,i).*Nmax ,'ob'); hold on; grid on
        plot(i,F_out(3,i),'+r');
        legend('Desejado','Obtido');
        xlabel('tempo');ylabel('Amplitude');
        title('TN'); axis([0 length(X) -15 15])
        drawnow
    end
end
% PlotFinalJunto(X,Y,Xmap,Ymap,F.*[Fmax;Fmax;Nmax],F_out,theta,Pwm,md,md1,'MURILLO',F_out1,theta1,Pwm1,md2,'FOSSEN')
% PlotFinal(X,Y,Xmap,Ymap,F.*[Fmax;Fmax;Nmax],F_out,theta,Pwm,md,md1,'MURILLO')
PlotAlocacaoCenario(TN,X,Y,Xmap,Ymap,TNmap,F.*[Fmax;Fmax;Nmax],F_out,Pwm,theta,ft,Nome,salva)
IAE = IAE(F.*[Fmax;Fmax;Nmax],F_out,1)
% PlotFinal(X,Y,Xmap,Ymap,F.*[Fmax;Fmax;Nmax],F_out1,theta1,Pwm1,md,md2,'FOSSEN')
% figure; 
% plot(md)
% hold on 
% plot(md1)
% ylim([ 0 1.1])