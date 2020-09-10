% Inicia todas as variáveis relacionadas à simulação em geral
% Sim
% Sim_Plot
function Initialisation(Nome_SP)

%% Global variable(s)
global numFig Sim Sim_Plot Time TimeJ SLC;
global M_PI DEG_TO_RAD RAD_TO_DEG WP;

numFig = 1;         % Initialises figure index
WP     = 1;         % Initialises WP index

%% Mantendo o padrão utilizado no C
M_PI       = pi;
DEG_TO_RAD = pi/180;
RAD_TO_DEG = 180/pi;

%% Creates the simulation time vector

SLC.Freq   = 20;       % Sucessive Loop Closure frequency % 90s Linear X / 

switch Nome_SP
    case 'Cenario1'
        TEMPO_Sim  = 60;       % Total simulation time [s]
    case 'Cenario2'
        TEMPO_Sim  = 76;       % Total simulation time [s]
    case 'Cenario3'
        TEMPO_Sim  = 182;       % Total simulation time [s]
    otherwise
        TEMPO_Sim  = 100;       % Total simulation time [s]
end

Ts         = 0.01;     % Integration step / sampling period [s]

Time  = Ts*SLC.Freq:Ts*SLC.Freq:TEMPO_Sim;  % Time Vector
TimeJ = Ts:Ts:TEMPO_Sim;                    % Auxiliar Time Vector

%% Newest simulation data structure (Sim)
Current_X_Y_psi = [1e-10;1e-10;1e-10];
Current_u_v_r   = zeros(3,1);
   
%% Simulation output data structure (Sim_Plot)
NetForcesAndMoments = [];
X_Y_psi             = [];
u_v_w               = [];

F   = zeros(3,1);
PWM = ones(4,1);
Th  = zeros(4,1);

u_v_r_dot = zeros(3,1);

% PositionAndAttitude
Sim_Plot = struct('NetForcesAndMoments', NetForcesAndMoments,'X_Y_psi',X_Y_psi,'u_v_w',u_v_w);

Sim = struct('Current_X_Y_psi',Current_X_Y_psi,'Current_u_v_r', Current_u_v_r,...
    'u_v_r_dot',u_v_r_dot,'tFinal',TEMPO_Sim,'Ts', Ts,'F',F,'PWM',PWM,...
    'Theta',Th,'Vel',zeros(3,1));
end
