clear all; close all; clc
global Pwmmax Pwmmin k1 k2 k3 k4 M_PI DEG_TO_RAD RAD_TO_DEG Fmax L Lx Ly Nmax APP Sim;

%% Mantendo o padr�o utilizado no C
M_PI = pi;
DEG_TO_RAD = pi/180;
RAD_TO_DEG = 180/pi;
Fmax = 0.86*9.81*4; % For�a max�ma real
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
% ==================================================================================

Nsim = 1;

dt      = 0.1;
T_final = 30;

SP_F_max  = 1;
SP_TN_max = 1;

Tempo = dt:dt:T_final;

Posicao = zeros(Nsim,length(Tempo));

SP_Fx =  generate_Sp(T_final,SP_F_max,dt,Nsim);
SP_Fy =  generate_Sp(T_final,SP_F_max,dt,Nsim);
SP_Tn =  generate_Sp(T_final,SP_TN_max,dt,Nsim);

% plotGeneratedSP(Tempo, SP_Fx, SP_Fy,SP_Tn,Nsim,'b');

for i=1:length(SP_Fx(:,1))
    
    for j=1:length(SP_Fx(1,:))
        % Mapeamento
        Xmap(i,j)  = (mapcube(SP_Fx(i,j),SP_Fy(i,j),SP_Tn(i,j)));
        Ymap(i,j)  = (mapcube(SP_Fy(i,j),SP_Fx(i,j),SP_Tn(i,j)));
        TNmap(i,j) = (mapcube(SP_Tn(i,j),SP_Fy(i,j),SP_Fx(i,j)));

%         Xmap(j)  = SP_Fx(i,j);
%         Ymap(j)  = SP_Fy(i,j);
%         TNmap(j) = SP_Tn(i,j);
        
    end
    F(i).SP = [Xmap(i,:)*Fmax; Ymap(i,:)*Fmax; TNmap(i,:)*Nmax];
end
% plotGeneratedSP(Tempo, Xmap, Ymap,TNmap,Nsim,'r');
% hold off

for i=1:Nsim
    %% matriz de aloca��o
    Out(i).theta = zeros(4,1);
    Out(i).Pwm   = zeros(4,1);
    Out(i).F_out = zeros(3,1);
    
    Out2(i).theta = zeros(4,1);
    Out2(i).Pwm   = zeros(4,1);
    Out2(i).F_out = zeros(3,1);
    
    for j=1:length(F(i).SP(1,:))-1
        
        [Out(i).theta(:,j+1),Out(i).Pwm(:,j+1)] = Allocation_FCA(F(i).SP(:,j),Out(i).theta(:,j),Out(i).Pwm(:,j)); 
        % Servor Dynamics
%         [Out(i).theta(:,j+1),Out(i).Pwm(:,j+1)] = DynamicsOfServosAndMotors((j+1),Out(i).theta,Out(i).Pwm);
        
        %% aloca��o direta para conferir
        Out(i).F_out(:,j+1)  = Aloc_Direta(Out(i).theta(:,j+1),Out(i).Pwm(:,j+1));
        
        %%
% %         %%
% %         [Out2(i).theta(:,j+1),Out2(i).Pwm(:,j+1)] = Allocation_Fossen(F(i).SP(:,j),Out2(i).theta(:,j),Out2(i).Pwm(:,j));  
% %         % Servor Dynamics
% %         [Out2(i).theta(:,j+1),Out2(i).Pwm(:,j+1)] = DynamicsOfServosAndMotors((j+1),Out2(i).theta,Out2(i).Pwm);
% %         
% %         %% aloca��o direta para conferir
% %         Out2(i).F_out(:,j+1)  = Aloc_Direta(Out2(i).theta(:,j+1),Out2(i).Pwm(:,j+1));
    end
    
    figure(i)
    subplot(311)
    plot(Tempo,F(i).SP(1,:),'b'); hold on; grid on;
    plot(Tempo,Out(i).F_out(1,:),'r');
    plot(Tempo,Out2(i).F_out(1,:),'g');legend('Fx SP', 'Fx FCA','Fossen');
    hold off
    
    subplot(312)
    plot(Tempo,F(i).SP(2,:),'b'); hold on; grid on;
    plot(Tempo,Out(i).F_out(2,:),'r');
    plot(Tempo,Out2(i).F_out(2,:),'g');legend('Fy SP', 'Fy FCA','Fossen');
    hold off
    
    subplot(313)
    plot(Tempo,F(i).SP(3,:),'b'); hold on; grid on;
    plot(Tempo,Out(i).F_out(3,:),'r'); 
    plot(Tempo,Out2(i).F_out(3,:),'g');legend('Tn SP', 'Tn FCA','Fossen');
    hold off
    drawnow
    
    index_IAE_Fx(i) = LEO(F(i).SP(1,:),Out(i).F_out(1,:),dt);
    index_IAE_Fy(i) = LEO(F(i).SP(2,:),Out(i).F_out(2,:),dt);
    index_IAE_Tn(i) = LEO(F(i).SP(3,:),Out(i).F_out(3,:),dt);
    
    index_IAE_Fx2(i) = LEO(F(i).SP(1,:),Out2(i).F_out(1,:),dt);
    index_IAE_Fy2(i) = LEO(F(i).SP(2,:),Out2(i).F_out(2,:),dt);
    index_IAE_Tn2(i) = LEO(F(i).SP(3,:),Out2(i).F_out(3,:),dt);
end

figure
subplot(311)
plot(index_IAE_Fx);hold on; plot(index_IAE_Fx2);legend('FCA Fx','Fossen Fx'); xlabel('Epoca');ylabel('%');title('MSE index');
subplot(312)
plot(index_IAE_Fy);hold on; plot(index_IAE_Fy2);legend('FCA Fy','Fossen Fy');  xlabel('Epoca');ylabel('%')
subplot(313)
plot(index_IAE_Tn);hold on; plot(index_IAE_Tn2);legend('FCA Tn','Fossen Tn');  xlabel('Epoca');ylabel('%')



% for i=1:Nsim
%     figure
%     plot(Tempo,SP(i,:))
% end
