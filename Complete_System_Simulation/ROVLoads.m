%==========================================================================
% This function computes the net forces and moments acting on the ROV
%==========================================================================
function ROVLoads(j)
% Global variable(s)
global Sim SimOutput_Plot Torque DEG_TO_RAD;

% Converts forces and moments which stem from the weight force from the NED frame to the BF frame, where g = 9.80665 [m/s^2] is the accel. of gravity
g_n = zeros(3,1);

% Hydrodynamic Resistance D(v)v
D_V = Hydro_Resist(); % Parte da Equação 7.06 -- Fossen

% Coriolis Effects C(v)v
Coriolis = Coriolis_Effect_Cat(); % Parte da Equação 7.06 -- Fossen
% 
% Sim.F(1,j) = mapcube(Sim.F(1,j),Sim.F(2,j),Sim.F(3,j));
% Sim.F(2,j) = mapcube(Sim.F(2,j),Sim.F(1,j),Sim.F(3,j));
% Sim.F(3,j) = mapcube(Sim.F(3,j),Sim.F(2,j),Sim.F(1,j));

% Totals the net forces and moments
[Sim.Theta(:,j+1),Sim.PWM(:,j+1)] = Allocation_Fossen(Sim.F(:,j),Sim.Theta(:,j),Sim.PWM(:,j));

% Sim.T(:,j) = Sim.Theta(:,j+1);
% Sim.P(:,j) = Sim.PWM(:,j+1);
% Servor Dynamics
% [Sim.Theta(:,j+1),Sim.PWM(:,j+1)] = DynamicsOfServosAndMotors((j+1),Sim.Theta,Sim.PWM);

Sim.F_out(:,j) = Aloc_Direta(Sim.Theta(:,j+1),Sim.PWM(:,j+1));

% Sim.Theta(:,j+1) = zeros(4,1);% zerando para Plot
% Sim.PWM(:,j+1)   = zeros(4,1);% zerando para Plot

Torque = Sim.F(:,j);%Sim.F_out(:,j);

% Sim.NetForcesAndMoments = Torque - D_V - Coriolis - g_n; % parte da equação 3.69 (segundo parentesis)
Sim.NetForces = D_V + Coriolis + g_n; % parte da equação 3.69 (segundo parentesis)

% Saves this(these) result(s) for later use
SimOutput_Plot.NetForcesAndMoments(:, j) = Sim.NetForces;

SimOutput_Plot.Theta(:,j)  = Sim.Theta(:,j+1)*DEG_TO_RAD;
SimOutput_Plot.PWM(:,j)    = Sim.PWM(:,j+1);