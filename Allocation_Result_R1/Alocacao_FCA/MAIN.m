close all; clear all; clc;

%% Carrega os Sps gerados em outro Arquivo
% Nesse caso identificou-se com com SPs senoidais o FCA teria uma
% "Vantagem" em relação aos demais (principalmente com cada sinal em
% frequencia diferente
load('../Cria_SPs/SetPoints.mat');

%% Caracteristicas físicas da embarcação
global Pwmmax Pwmmin APP k1 Sim Fmax L Lx Ly Nmax ;

L   = 0.586;
Fmax = 2.1*9.81*4; % Força maxíma real

% Saturações de Força e torque
Nmax   = L*Fmax;
Pwmmax = 1001.0;
Pwmmin = 1.0;

% Braços de alavanca do Motor
Lx = L*cos(pi/4.0);
Ly = L*cos(pi/4.0);

% Constante de propulsão do motor
k1 = (Fmax/4.0)/(Pwmmax-Pwmmin);

% Constante de Tempo para dinamica dos atuadores (Parametros do Murillo)
settling_time_mt  = 0.3;
settling_time_srv = 1.5;

Sim.Ts = Ts;

APP.tau_mt  = settling_time_mt/5;    % Motors
APP.tau_srv = settling_time_srv/5;   % Servos

% Variavel de plot (0 ou 1)
PlotarCenarios = 1;

Erro        = zeros(3,1);
ISE_FCA     = zeros(3,1);
F_desejado  = zeros(3,1);

tic;
for i=1:length(SP)  % O numero de SPs será o número de simulações ( Cada SP possui 3 sinais de N segundos)
    
    Out(i).Th          = zeros(4,1);
    Out(i).PWM         = ones(4,1);
    Out(i).F_out_FCA   = zeros(3,1);
    Out(i).Erro_FCA    = zeros(3,1);
    
    for j=1:length(SP(i).F_Mapeado(1,:))
        
        if j==1
            % Alocação
            [Out(i).Th(:,j),Out(i).PWM(:,j),Out(i).Erro_FCA(:,j),Out(i).F_out_FCA(:,j)] = Allocation_FCA(SP(i).F_Mapeado,Out(i).Th,Out(i).PWM,2);
        else
            % Alocação
            [Out(i).Th(:,j),Out(i).PWM(:,j),Out(i).Erro_FCA(:,j),Out(i).F_out_FCA(:,j)] = Allocation_FCA(SP(i).F_Mapeado,Out(i).Th,Out(i).PWM,j);
        end
        
        % Servor Dynamics
%         [Out(i).Th(:,j),Out(i).PWM(:,j)] = DynamicsOfServosAndMotors(j,Out(i).Th,Out(i).PWM);
        
        % Alocação Direta depois da dinamica dos atuadores
        Out(i).F_Saida(:,j) = Aloc_Direta(Out(i).Th(:,j),Out(i).PWM(:,j));
        
        % Erro Ponto a ponto
        Out(i).Erro_Saida_Final(:,j) = SP(i).F_Mapeado(:,j)- Out(i).F_Saida(:,j);
        
    end
    ISE_FCA(:,i) = (sum((Out(i).Erro_Saida_Final.^2)').*Sim.Ts)'; % ISE (Utilizdo no paper do Murillo)
end

Total_tempo = toc

if PlotarCenarios
    for i=1:length(SP)
        %% Força de saida
        figure
        ax(2) = subplot(311);
        plot(Time,Out(i).F_Saida(1,:),'b'); hold on
        plot(Time,SP(i).F_Mapeado(1,:),'r')
        legend('Obtido','Desejado') ; title('Fx');
        grid on
        ax(1) = subplot(312);
        plot(Time,Out(i).F_Saida(2,:),'b'); hold on
        plot(Time,SP(i).F_Mapeado(2,:),'r');
        legend('Obtido','Desejado') ; title('Fy');
        grid on
        ax(3) = subplot(313);
        plot(Time,Out(i).F_Saida(3,:),'b'); hold on
        plot(Time,SP(i).F_Mapeado(3,:),'r')
        legend('Obtido','Desejado') ; title('Yaw');    grid on
        
        %% PWM de saida
        figure
        ax(1) = subplot(411);
        plot(Time,Out(i).PWM(1,:),'b'); hold on
        legend('Motor 1') ; title('PWM');    grid on
        
        ax(2) = subplot(412);
        plot(Time,Out(i).PWM(2,:),'b'); hold on
        legend('Motor 2') ;    grid on
        
        ax(3) = subplot(413);
        plot(Time,Out(i).PWM(3,:),'b'); hold on
        legend('Motor 3') ;    grid on
        
        ax(4) = subplot(414);
        plot(Time,Out(i).PWM(4,:),'b'); hold on
        legend('Motor 4') ;    grid on
        % linkaxes(ax,'xy')
        
        %% Theta de saida
        figure
        ax(1) = subplot(411);
        plot(Time,Out(i).Th(1,:).*(180/pi),'b'); hold on
        legend('Theta 1') ; title('Angulo');    grid on
        
        ax(2) = subplot(412);
        plot(Time,Out(i).Th(2,:).*(180/pi),'b'); hold on
        legend('Theta 2') ;    grid on
        
        ax(3) = subplot(413);
        plot(Time,Out(i).Th(3,:).*(180/pi),'b'); hold on
        legend('Theta 3') ;    grid on
        
        ax(4) = subplot(414);
        plot(Time,Out(i).Th(4,:).*(180/pi),'b'); hold on
        legend('Theta 4') ;    grid on
        % linkaxes(ax,'xy')
        
        %% Error
        figure
        ax(2) = subplot(311);
        plot(Time,Out(i).Erro_Saida_Final(1,:),'b'); hold on
        legend('Fx FCA') ; title('Erro Final');    grid on
        
        ax(1) = subplot(312);
        plot(Time,Out(i).Erro_Saida_Final(2,:),'b'); hold on
        legend('Fy FCA') ; title('Erro Final');    grid on
        
        ax(3) = subplot(313);
        plot(Time,Out(i).Erro_Saida_Final(3,:),'b'); hold on
        legend('Tn FCA') ; title('Erro Final');    grid on
        
        drawnow
    end
end
figure
ax(2) = subplot(311);
plot(ISE_FCA(1,:),'b'); hold on
legend('Fx FCA'); xlabel('Simulacao'); ylabel('Un')
grid on

ax(1) = subplot(312);
plot(ISE_FCA(2,:),'b'); hold on
legend('Fx FCA'); xlabel('Simulacao'); ylabel('Un')
grid on

ax(3) = subplot(313);
plot(ISE_FCA(3,:),'b'); hold on
legend('Fx FCA'); xlabel('Simulacao'); ylabel('Un')
grid on

MeanISE = sum(ISE_FCA')./length(ISE_FCA)
