clear all; close all; clc;

%% Configuration
Possible_SPs = {'Guinada','Sway','LinearY','LinearX','Circular','Oito','Figura'};
Language     = {'Portugues','Ingles'};

SetPoint = Possible_SPs{4};
Lang     = Language{2};

% Plot Configuration
Plotar = 1;  % 1 - True or 0 - False
Salvar = 1;  % 1 - True or 0 - False

Plot_Step = 20; % Step to dynamic plot

%% Initialisation
Initialisation;       % Time and some variables
NoiseInitialization;  % Initialize the systems noise

%% Global variable(s) - MUST COME HERE, strictly after the initialisation
global Sim Sim_Plot Time ROV Torque SLC SP WP ;
%% Auxiliar variables to integrate
Aux = [];

%% Catamaran Physical Properties
PhysicalProperties;

%% Control gain Project
Calc_Controllers;

%% Creates SetPoints to Be Tracked
SetPointsCreation(SetPoint);

%% Choose which controller is going to be used
switch SetPoint
    case {'Figra','LinarX','Circlar'}
        L1_controller = 1;
    otherwise
        L1_controller = 0;
end

%% Starts the stopwatch timer and iterative simulation
tic;
for i = 1:numel(Time)
    
    WaypointUpdate;
    
    Position_Controller(i);
    
    if norm(SP.XYZ(:,end) - Sim.Current_X_Y_psi) <ROV.WpRadius 
        Sim.Vel(:,i)=[0;0;0];
    end
    
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
        (Torque - Sim.NetForces)
        %% Double integration: accelerations -> velocities -> position/attitude
        X = [n_dot; v_dot]; % Vetor de Estados
        [AuxVector, Aux] = Integration(X,Aux,j);
        
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
    if(mod(i,Plot_Step)==0 && Plotar==1)
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

Curvas_real_simulado(10,SetPoint,Lang,Salvar);            % Demais figuras

%% End of the script
delete *.asv;
