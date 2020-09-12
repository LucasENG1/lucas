clear all; close all; clc;
%% Configuration
global Sim Sim_Plot Time ROV Torque SLC SP WP  TimeJ RAD_TO_DEG;

% Plot Configuration
Plot      = 00;         % 1 - Plot online Figures or      0 - False
Plot_Step = 20;         % Step to dynamic plot
Salvar    = 01;         % 1 - Save Data to Plot Figure or 0 - False

Artigo1  = {'Cenario1','Cenario2','Cenario3'}; % Possible scenarios name
SetPoint = Artigo1{3};

%% Initialisation
Initialisation(SetPoint);       % Time and some variables

NoiseInitialization;            % Initialize the systems noise

PhysicalProperties;             % Catamaran Physical Properties

Calc_Controllers;               % Control gain Project

SetPointsCreation(SetPoint);    % Creates SetPoints to be Tracked


%% Auxiliar variables
Aux = [];

%% Start Simulation 
tic;                % Starts the stopwatch timer and iterative simulation

for i = 1:numel(Time)
    
    WaypointUpdate;             % Updates the current waypoint
    
    Point_of_interest([15,15]);
    
    Position_Controller(i);     % Updates de basic position controller

%     if(WP>length(SP.XYZ(1,:))-1)
%         Sim.Vel(:,i)  = [0;0;0];
%     end
    
%     if(L1_controller==1)
%         Path_L1_controller(i);
%     else
%         Line_of_sight(i);
%     end

    for j = (SLC.Freq*(i-1)+1):SLC.Freq*(i)
        %% Controlador de Velocidade
        Speed_Controller(i,j);

        %% Computes the net forces and moments acting on the ROV
        ROVLoads(j);
        
        n_dot = BF2NED(Sim.Current_X_Y_psi(3),Sim.Current_u_v_r);
        v_dot = ROV.InverseInertia * (Torque - Sim.NetForces);
        %% Double integration: accelerations -> velocities -> position/attitude
        X                = [n_dot; v_dot];             % State vector
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
    % Plot online Figure
    if(mod(i,Plot_Step)==0 && Plot==1)
        Plot_general(j);
        pause(1)
    end
    
end


%% Calculo do Indices
Vel_IAE  = IAE(Sim_Plot.SP_Vel,Sim_Plot.u_v_r,Sim.Ts)
Posi_IAE = IAE(Sim_Plot.SP_Posi,Sim_Plot.X_Y_psi,Sim.Ts)

%% Plot das Figuras
% FiguraAutopilot(spd,5*ayp,Sim_Plot.SP_Posi,salva);  % Autopilot Figure
%% Save Data to Future Figures
save(strcat('Simulado/',strcat('Sim_',SetPoint)),'SetPoint','Sim','Sim_Plot','TimeJ','RAD_TO_DEG','ROV');

Curvas_real_simulado(10,SetPoint,'Ingles',Salvar);            % Demais figuras

%     if norm(SP.XYZ(:,end) - Sim.Current_X_Y_psi) <ROV.WpRadius 
%         Sim.Vel(:,i)=[0;0;0];
%     end

%% Stops and reads the stopwatch timer

elapsedTime = toc;
fprintf('Total simulation time = %0.4fs\n', elapsedTime);    
