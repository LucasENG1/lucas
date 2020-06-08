%% FAZ A LEITURA DAS FORÇAS ENVIADAS NA PRÁTICA E COMPARA O SIMULADO E O REAL (ACACCIO)
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
%  tscp | t_tau| Fx | Fy | Tn |t_GPS|  lat |lon | hdg|  vx |vy |t_IMU| roll | pitch | yaw | yawspeed

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
global Sim Sim_Plot ROV Torque SLC Fmax Nmax Log;
%% Auxiliar variables to integrate
Aux = [];

%% Catamaran Physical Properties
PhysicalProperties;

%%
Arquivo = importdata('DadosColetadosDoTeste.txt',' ');

Log.Temp  = Arquivo(:,2)';
Log.Temp  = (Log.Temp-Log.Temp(1))./1000;

Log.Fx = Arquivo(:,3)' ;
Log.Fy = Arquivo(:,4)' ;
Log.Tn = Arquivo(:,5)' ;

Lat = Arquivo(:,7)'./1e7 ;
Lon = Arquivo(:,8)'./1e7 ;


[px py] = LatLonToMeters2(Lat, Lon);

Log.Px = px - px(1);
Log.Py = py - py(1);
Log.Hdg = Arquivo(:,9)'./100 ;

Log.Fx = (Log.Fx -Log.Fx(1))./(max(Log.Fx)- min(Log.Fx));
Log.Fy = (Log.Fy -Log.Fy(1))./(max(Log.Fy)- min(Log.Fy));

Log.Tn = (Log.Tn -Log.Tn(1))./(max(Log.Tn)- min(Log.Tn));



Log.Fx = Log.Fx .* Fmax;
Log.Fy = Log.Fy .* Fmax;
Log.Tn = Log.Tn .* Nmax;

% % Filtro
% Log.Tn(abs(Log.Tn)<0.5)=0;
% Log.Fx(abs(Log.Fx)<5) = 0;
% Log.Fy(abs(Log.Fy)<6) = 0;



Log.Vx_NED = Arquivo(:,10)'./100;
Log.Vy_NED = Arquivo(:,11)'./100;
Log.Vyaw = Arquivo(:,16)';

for i=1:length(Log.Vx_NED)
    V = NED2BF((Log.Hdg(i)-0)*(pi/180),[Log.Vx_NED(i); Log.Vy_NED(i); 0]);
    Log.Vx(i) = V(1);
    Log.Vy(i) = V(2);    
end

Sim.Current_X_Y_psi = [Log.Px(1); Log.Py(1); Log.Hdg(1)*(pi/180)];
 

dt = Log.Temp(end)/length(Log.Temp);

Time  = dt*SLC.Freq:dt*SLC.Freq:Log.Temp(end);
TimeJ = dt:dt:Log.Temp(end);

Sim.Ts = dt;

%% Control gain Project
Calc_Controllers;

%% Starts the stopwatch timer and iterative simulation
h = 1;
tic;
for i = 1:numel(Time)
    
    for j = (SLC.Freq*(i-1)+1):SLC.Freq*(i)
        if(TimeJ(j) >= Log.Temp(h) && h< length(Log.Temp) )
            FF= [Log.Fx(h);Log.Fy(h);Log.Tn(h)];
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
        
        Sim.Current_X_Y_psi(3) = mod(Sim.Current_X_Y_psi(3),2*pi);
        
        
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
