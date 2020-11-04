 
close all; clear all; clc;

load('SetPoints.mat')

global Pwmmax Pwmmin APP k1 k2 k3 k4 Sim Fmax L Lx Ly Nmax ;

%% Mantendo o padrão utilizado no C
L   = 0.586;
Fmax = 2.1*9.81*4; % Força maxíma real
Nmax = L*Fmax;

Pwmmax = 1001.0;
Pwmmin = 1.0;
Lx = L*cos(pi/4.0);
Ly = L*cos(pi/4.0);
k1 = (Fmax/4.0)/(Pwmmax-Pwmmin);
k2 = k1;k3 = k1;k4 = k1;

%% Constante de Tempo
settling_time_mt  = 0.3;
settling_time_srv = 1.5;

tau_mt  = settling_time_mt/5;    % Motors
tau_srv = settling_time_srv/5;   % Servos

APP    = struct('tau_mt', tau_mt,'tau_srv',tau_srv);
Sim.Ts = 0.01;

Erro        = zeros(3,1);
ISE_FCA     = zeros(3,1);
F_desejado  = zeros(3,1);

for i=1:length(SP)
    
    Out(i).Th          = zeros(4,1);
    Out(i).PWM         = zeros(4,1);
    Out(i).F_out_FCA   = zeros(3,1);
    Out(i).Erro_FCA    = zeros(3,1);
    
    for j=2:length(SP(i).F_Map(1,:))
        % Alocação por FCA
        [Out(i).Th(:,j),Out(i).PWM(:,j),Out(i).Erro_FCA(:,j),Out(i).F_out_FCA(:,j)] = Allocation_FCA(SP(i).F_Map,Out(i).Th,Out(i).PWM,j);
        
    end
    ISE_FCA(:,i) = (sum((Out(i).Erro_FCA.^2)').*Sim.Ts)';
    
end

% for i=1:length(SP)
%     %% Força de saida
%     figure(i)
%     ax(2) = subplot(311);
%     plot(Time,Out(i).F_out_FCA(1,:),'b'); hold on
%     plot(Time,SP(i).F_Map(1,:),'r')
%     legend('Obtido','Desejado') ; title('Fx');
%     grid on
%     ax(1) = subplot(312);
%     plot(Time,Out(i).F_out_FCA(2,:),'b'); hold on
%     plot(Time,SP(i).F_Map(2,:),'r');
%     legend('Obtido','Desejado') ; title('Fy');
%     grid on
%     ax(3) = subplot(313);
%     plot(Time,Out(i).F_out_FCA(3,:),'b'); hold on
%     plot(Time,SP(i).F_Map(3,:),'r')
%     legend('Obtido','Desejado') ; title('Yaw');    grid on
%     
%     %% PWM de saida
%     figure(2*i)
%     ax(1) = subplot(411);
%     plot(Time,Out(i).PWM(1,1:length(Time)),'b','Parent',ax(1)); hold on
%     legend('Motor 1') ; title('PWM');    grid on
%     
%     ax(2) = subplot(412);
%     plot(Time,Out(i).PWM(2,1:length(Time)),'b','Parent',ax(2)); hold on
%     legend('Motor 2') ;    grid on
%     
%     ax(3) = subplot(413);
%     plot(Time,Out(i).PWM(3,1:length(Time)),'b','Parent',ax(3)); hold on
%     legend('Motor 3') ;    grid on
%     
%     ax(4) = subplot(414);
%     plot(Time,Out(i).PWM(4,1:length(Time)),'b','Parent',ax(4)); hold on
%     legend('Motor 4') ;    grid on
%     % linkaxes(ax,'xy')
%     
%     %% Theta de saida
%     figure(3*i)
%     ax(1) = subplot(411);
%     plot(Time,Out(i).Th(1,1:length(Time))*(180/pi),'b','Parent',ax(1)); hold on
%     legend('Theta 1') ; title('Angulo');    grid on
%     
%     ax(2) = subplot(412);
%     plot(Time,Out(i).Th(2,1:length(Time))*(180/pi),'b','Parent',ax(2)); hold on
%     legend('Theta 2') ;    grid on
%     
%     ax(3) = subplot(413);
%     plot(Time,Out(i).Th(3,1:length(Time))*(180/pi),'b','Parent',ax(3)); hold on
%     legend('Theta 3') ;    grid on
%     
%     ax(4) = subplot(414);
%     plot(Time,Out(i).Th(4,1:length(Time))*(180/pi),'b','Parent',ax(4)); hold on
%     legend('Theta 4') ;    grid on
%     % linkaxes(ax,'xy')
%     
%     %% Error
%     figure(4*i)
%     ax(2) = subplot(311);
%     plot(Time,Out(i).Erro_FCA(1,:),'b'); hold on
%     legend('Fx FCA') ; title('SE');    grid on
%     
%     ax(1) = subplot(312);
%     plot(Time,Out(i).Erro_FCA(2,:),'b'); hold on
%     legend('Fy FCA') ; title('SE');    grid on
%     
%     ax(3) = subplot(313);
%     plot(Time,Out(i).Erro_FCA(3,:),'b'); hold on
%     legend('Tn FCA') ; title('SE');    grid on
%     
%     drawnow
% end

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
