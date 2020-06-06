%%
%                           CATAMARAN
%                              ^
%                              |-y
%               -------------------------------
%              |    Mot.2           Mot.3       >
%               -------------------------------
%                             ||                      ---> x
%               -------------------------------
%              |    Mot.4           Mot.1       >
%               -------------------------------
% Obs: Por convenção os motores puxam o barco:
%      Angulo do propulsor +  ---> Embarcação se move para direita
%      Angulo do propulsor -  ---> Embarcação se move para esquerda
% =========================================================================
clear all; close all; clc;
%  tscp | t_tau| Fx | Fy | Tn     |t_GPS|      lat |     lon |   hdg|       vx |     vy      |t_IMU| roll | pitch | yaw | yawspeed

%% Configuration
% Possible_SPs = {'Guinada','Sway','LinearY','LinearX','Circular','Oito','Figura'};
Language     = {'Portugues','Ingles'};

% SetPoint = Possible_SPs{7};
Lang     = Language{2};

% Plot Configuration
Plotar = 1;  % 1 - True or 0 - False
Salvar = 0;  % 1 - True or 0 - False

Plot_Step = 1; % Step to dynamic plot

%% Initialisation
Initialisation;       % Time and some variables
NoiseInitialization;  % Initialize the systems noise

%% Global variable(s) - MUST COME HERE, strictly after the initialisation
global Sim Sim_Plot ROV Torque SLC Fmax Nmax ;
%% Auxiliar variables to integrate
Aux = [];

%% Catamaran Physical Properties
PhysicalProperties;

%%
Arquivo = importdata('DadosColetadosDoTeste.txt',' ');

T  = Arquivo(:,2)';
T  = (T-T(1))./1000;

Fx = Arquivo(:,3)' ;
Fy = Arquivo(:,4)' ;
Tn = Arquivo(:,5)' ;

Fx = (Fx -Fx(1))./(max(Fx)- min(Fx));
Fy = (Fy -Fy(1))./(max(Fy)- min(Fy));
Tn = (Tn -Tn(1))./(max(Tn)- min(Tn));

Fx = Fx .* Fmax;
Fy = Fy .* Fmax;
Tn = Tn .* Nmax;

dt = T(end)/length(T);

Time = dt*SLC.Freq:dt*SLC.Freq:T(end);
TimeJ = dt:dt:T(end);

Sim.Ts = dt;

%% Control gain Project
Calc_Controllers;

%% Starts the stopwatch timer and iterative simulation
h = 1;
tic;
for i = 1:numel(Time)
    
    
    
    for j = (SLC.Freq*(i-1)+1):SLC.Freq*(i)
        if(TimeJ(j) >= T(h) && h< length(T) )
            FF = [Fx(h);Fy(h);Tn(h)];
            h = h+1;
        end
        
        %% Inserção das Forças Salvas pelo Accacio
        Sim.F(:,j)= FF;
        %% Computes the net forces and moments acting on the ROV
        ROVLoads(j);
        
        n_dot = BF2NED(Sim.Current_X_Y_psi(3),Sim.Current_u_v_r);
        v_dot = ROV.InverseInertia * (Torque - Sim.NetForces);
        
        %% Double integration: accelerations -> velocities -> position/attitude
        X = [n_dot; v_dot]; % Vetor de Estados
        [AuxVector, Aux] = Integration(X,Aux,j);
        
        Sim.u_v_r_dot(:,j+1) = v_dot;         % utilizada no controle de Velocidade
        Sim.Current_X_Y_psi  = AuxVector(1:3);% + sqrt(R_gps)*randn(size(AuxVector(1:3)));
        Sim.Current_u_v_r    = AuxVector(4:6);% + sqrt(R_gps)*randn(size(AuxVector(1:3)));
        %% Armazena para PLOT
        Sim_Plot.u_v_r(:,j)   = Sim.Current_u_v_r;
        Sim_Plot.X_Y_psi(:,j) = Sim.Current_X_Y_psi;
        
    end
    % Plota a figura dinamica
    if(mod(j,Plot_Step)==0 && Plotar==1)
        Plot_general(j,TimeJ(j))
    end
    
end
TimeJ = Time;
%% Stops and reads the stopwatch timer
elapsedTime = toc;
fprintf('Total simulation time = %0.4fs\n', elapsedTime);

Curvas_real_simulado(10,'NomeSP',Lang,Salvar);            % Demais figuras

%% End of the script
delete *.asv;
