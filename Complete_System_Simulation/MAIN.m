clear all; close all; clc;
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
% Obs: Por conven��o os motores puxam o barco:
%      Angulo do propulsor +  ---> Embarca��o se move para direita
%      Angulo do propulsor -  ---> Embarca��o se move para esquerda
% =========================================================================

%% Configuration
Nome_vetor = {'Guinada','Sway','LinearY','LinearX','Circular','Oito','Figura'};
Nome = Nome_vetor{5};

Language = {'Portugues','Ingles'};
Lang = Language{2};
% Plot Configuration
plt   = 1;
passo_plt = 20;
salva = 1;

%% Initialisation
Initialisation;
% Ru�do do Sistema
InicializaRuido
%% Global variable(s) - MUST COME HERE, strictly after the initialisation
global Sim Sim_Plot Time ROV Torque SLC SP WP yaw  V ;
V = zeros(1,numel(Time)*SLC.Freq);
yaw = 0;
%% Catamaran Physical Properties
PhysicalProperties;

%% Calcula os ganhos dos controladores
Calc_Controllers;
%% Creates SetPoints to Be Tracked
SetPointsCreation(Nome);

%% Controle de Posi��o
switch Nome
    case {'Figura','LinearX','Oito'}
        L1_controller = 1;
    otherwise
        L1_controller = 0;
end

%% Auxiliar variables to integrate
Aux = [];

%% Starts the stopwatch timer
tic;
for i = 1:numel(Time)
    %% Desenvolvimento do caminho
    if((norm(SP.XYZ(1:2,WP) - Sim.Current_X_Y_psi(1:2)))<3 && WP<length(SP.XYZ(1,:)))
        WP = WP+1;
    end
    
      Position_Controller(i);       
     
    if(L1_controller==1)
        Path_L1_controller(i);
    else
        Line_of_sight(i);
    end   
    for j = (SLC.Freq*(i-1)+1):SLC.Freq*(i)
        %% Controlador de Velocidade
        Speed_Controller(i,j);
        
        %% Computes the net forces and moments acting on the ROV
        ROVLoads(j);      
        n_dot = BF2NED(Sim.Current_X_Y_psi(3),Sim.Current_u_v_r);
        v_dot = ROV.InverseInertia * (Torque - Sim.NetForces);
        
        %% Double integration: accelerations -> velocities -> position/attitude
        X = [n_dot; v_dot]; % Vetor de Estados
        [AuxVector, Aux] = Integra(X,Aux,j);
        
        Sim.u_v_r_dot(:,j+1) = v_dot;         % utilizada no controle de Velocidade
        Sim.Current_X_Y_psi  = AuxVector(1:3);% + sqrt(R_gps)*randn(size(AuxVector(1:3)));
        Sim.Current_u_v_r    = AuxVector(4:6);% + sqrt(R_gps)*randn(size(AuxVector(1:3)));   
        %% Armazena para PLOT
        Sim_Plot.u_v_r(:,j)   = Sim.Current_u_v_r;
        Sim_Plot.X_Y_psi(:,j) = Sim.Current_X_Y_psi;
        Sim_Plot.SP_Posi(:,j) = SP.XYZ(:,WP);
        Sim_Plot.SP_Vel(:,j)  = Sim.Vel(:,i);
        
        spd(:,j) = BF2NED(Sim.Current_X_Y_psi(3),[Sim.Vel(1,i);0;0]);
        ayp(:,j) = BF2NED(Sim.Current_X_Y_psi(3),[0;2*Sim.Vel(2,i);0]);
    end
    % Plota a figura dinamica
    if(mod(i,passo_plt)==0 && plt==1)
        Plot_general(j)
    end
    
end
%% Stops and reads the stopwatch timer
elapsedTime = toc;
fprintf('Total simulation time = %0.4fs\n', elapsedTime);

%% Calculo do Indices
Vel_IAE  = IAE(Sim_Plot.SP_Vel,Sim_Plot.u_v_r,Sim.Ts)
Posi_IAE = IAE(Sim_Plot.SP_Posi,Sim_Plot.X_Y_psi,Sim.Ts)

%% Plot das Figuras
% FiguraAutopilot(spd,5*ayp,Sim_Plot.SP_Posi,salva);  % Autopilot

Curvas_real_simulado(10,Nome,Lang,salva);            % Demais figuras

%% End of the script
delete *.asv;



















