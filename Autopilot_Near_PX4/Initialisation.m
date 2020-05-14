%==========================================================================
% This function closes all figures and clears all variables and functions
% from memory at first; then it initialises i) the data structure that
% stores the newest simulation data, ii) the data structure that stores the
% control data, and iii) the data structure that stores the simulation out-
% put
%==========================================================================
function Initialisation

%% Closes all figures and clears all variables and functions from memory
close all; clear all; clc;

%% Global variable(s)
global Ctrl numFig Sim SimOutput_Plot Time TimeJ SLC Sat Auto yawIni;
global Pwmmax Pwmmin M_PI DEG_TO_RAD RAD_TO_DEG Fmax L Lx Ly Nmax k1 WP;

WP=1;
%% Mantendo o padrão utilizado no C
M_PI = pi;
DEG_TO_RAD = pi/180;
RAD_TO_DEG = 180/pi;

L    = 0.586;

Fmax = 2.6*9.81*4; % Força maxíma real
Nmax = L*Fmax;

Pwmmax = 1001.0;
Pwmmin = 1.0;

Lx = L*cos(M_PI/4.0);
Ly = L*cos(M_PI/4.0);
k1 = (Fmax/4.0)/(Pwmmax-Pwmmin);

%% Initialises figure counter
numFig = 1;

% Frequencia Sucessive Loop Closure
SLC.Freq = 10;

% Total simulation time [s]
tFinal = 72;  % REAL DUROU 90S 
% Integration step / sampling period [s]
Ts = 0.01;

%% Creates the simulation time vector
Time  = Ts*SLC.Freq:Ts*SLC.Freq:tFinal;
TimeJ = Ts:Ts:tFinal;

MaxVelX = 2.5;
MaxVelY = 0.5;
MaxVelAng =30*pi/180; 

%% Newest simulation data structure (Sim)
yawIni = -0*pi/2;

Current_X_Y_psi = [1e-10;1e-10;yawIni];
Current_u_v_r   = zeros(3, 1);

%% Control data structure (Ctrl)
errPXPrev    = 0;  errIXPrev   = 0;
errPYPrev    = 0;  errIYPrev   = 0;
errPYawPrev  = 0;  errIYawPrev = 0;

errPVXPrev   = 0;  errIVXPrev  = 0;
errPVYPrev   = 0;  errIVYPrev  = 0;
errPVYawPrev = 0; errIVYawPrev = 0;

%% Controle de Posição
kPX = 2 ;
kIX = 0.1 * 0 ;
kDX = 0.1 ;

kPY = 2*5;
kIY = 0.1  *0;
kDY = 0.1;

kPYaw = 2.0;
kIYaw = 0;
kDYaw = 0.1;

%% Controle de Velociadade
kPVX = Fmax/MaxVelX ; %40.8;
kIVX = kPVX/2;
kDVX = 1;

kPVY = Fmax/MaxVelY ;%150;
kIVY = kPVY;
kDVY = 1;

kPVYaw = Nmax/MaxVelAng ;%70;
kIVYaw = 0.0;
kDVYaw = 0.0;

%% Simulation output data structure (SimOutput_Plot)
NetForcesAndMoments = [];
X_Y_psi             = [];
u_v_w               = [];

F   = zeros(3,1);
PWM = ones(4,1);
Th  = zeros(4,1);

u_v_r_dot = [0;0;0];

Sat = struct('F_motor',Fmax,'torque', Nmax,'MaxVelX',MaxVelX,'MaxVelY',MaxVelY,'MaxVelAng',MaxVelAng);

% PositionAndAttitude
SimOutput_Plot = struct('NetForcesAndMoments', NetForcesAndMoments, 'X_Y_psi',X_Y_psi,'u_v_w', u_v_w);

Sim = struct('Current_X_Y_psi',Current_X_Y_psi,'Current_u_v_r', Current_u_v_r,...
    'u_v_r_dot',u_v_r_dot,'tFinal',tFinal,'Ts', Ts,'F',F,'PWM',PWM,'Theta',Th);

Auto.XY = zeros(3,1);Auto.d_dot = 0;Auto.d = 0;Auto.n = 0;

Sim.Vel = zeros(3,1);

Ctrl = struct('kPVX',kPVX,'kIVX',kIVX,'kDVX',kDVX,'kPVY',kPVY,'kIVY',kIVY,'kDVY',kDVY,...
    'kPVYaw',kPVYaw,'kIVYaw',kIVYaw,'kDVYaw',kDVYaw,...
'kPX',kPX,'kIX',kIX,'kDX',kDX,'kPY',kPY,'kIY',kIY,'kDY',kDY,...
    'kPYaw',kPYaw,'kIYaw',kIYaw,'kDYaw',kDYaw,'errIXPrev',errIXPrev,'errIYPrev',errIYPrev,...
    'errPXPrev',errPXPrev,'errPYPrev',errPYPrev,'errIYawPrev',errIYawPrev,'errPYawPrev',errPYawPrev,...
'errIVXPrev',errIVXPrev,'errPVXPrev',errPVXPrev,'errIVYPrev',errIVYPrev,...
    'errPVYPrev',errPVYPrev,'errIVYawPrev',errIVYawPrev,'errPVYawPrev',errPVYawPrev);