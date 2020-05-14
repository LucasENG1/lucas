%==========================================================================
% CATAMARAN MODEL PARAMETERS
%==========================================================================
function PhysicalProperties
% Global variable(s)
global ROV APP;

% Parametros construtivos
m     =      250;
xg    =     0.0;
Iz    =       15;

% Distância dos propulsores ao centro
Lx = 1.0;
Ly = 1.0;
L = sqrt(Lx^2+Ly^2);

% Parametros relacionados ao desenho (plot) do barco
Loa   =    6.09;             % Comprimento do casco (metros)
dcx   =   Loa/2;
Bw1   =    0.3;              % Largura da linha dágua [m]
dcbby =      Lx;
dceby =  -dcbby;

% Parametros de massa adicionada
Xudot =  0*-11.2;
Yvdot =  0*-68.1;
Yrdot =  0*-172.2;
Nrdot =  0*-148.8;

% Parametros de amortecimento não linear e linear
Xuu   =    -22.3;       Xu    =     -9.6;
Yvv   =        0;       Yv    =  -132.24;
Yvr   =   499e-5;       Yr    =   2.0987;
Yrr   =   499e-5;       Nv    =   1.6543;
Yrv   =   556e-5;       Nr    =    -65.6;
Nrv   =   166e-5;
Nvv   =   489e-5;
Nvr   =  5483e-5;
Nrr   =    -56.6;

% Parametros de propulsores
Fmax = (m*0.3); % Força maxima do barco - todos os motores em conjunto 
PWM_min = 1;
PWM_max = 2000;
k1  = Fmax/(4*(PWM_max-PWM_min));

%% Momentos e produtos de Inércia

CG = [xg;0;0];
% Matriz de massa de corpo rígido

IMrb = [ m       0       0; 
         0       m    m*xg; 
         0    m*xg      Iz];

% Matrix de massa adicionada
IMra =  [ -Xudot    0         0; 
          0     -Yvdot    -Yrdot; 
          0     -Yrdot    -Nrdot]; 

%% Matriz de massa
IM = IMrb + IMra;                              

%% Saturacao de cada motor do barco

theta_m1 = 0;
theta_m2 = 0;
theta_m3 = 0;
theta_m4 = 0;

settling_time_mt  = 0.3;
settling_time_srv = 1.5;

tau_mt  = settling_time_mt/5;    % Motors
tau_srv = settling_time_srv/5;   % Servos


%% Structure Creation
ROV = struct('Name', 'Airplane Physical Properties (APP)', 'mass', m,...
    'ICG', Iz, 'InertiaMatrix', IMrb, 'IMrb', IMra, 'IMra', IM,...
    'InverseInertia', inv(IM),'Xudot', Xudot, 'Yvdot', Yvdot, 'Yrdot', Yrdot,...
    'Nrdot', Nrdot, 'Xuu', Xuu, 'Yvv', Yvv, 'Yvr', Yvr, 'Yrr', Yrr, ...
    'Yrv', Yrv, 'Nrv', Nrv, 'Nvv', Nvv, 'Nvr', Nvr, 'Nrr', Nrr, ...
    'Xu', Xu, 'Yv', Yv, 'Yr', Yr, 'Nv', Nv, 'Nr', Nr, 'dcx', dcx,...
    'dcbby', dcbby, 'dceby', dceby, 'CG', CG,'Bw1',Bw1,'Loa',Loa,'Lx',Lx,...
    'Ly',Ly,'k1',k1,'L',L,'theta_m1',theta_m1,'theta_m2',theta_m2,...
    'theta_m3',theta_m3,'theta_m4',theta_m4,'Fmax',Fmax,'PWM_min',PWM_min,...
    'PWM_max',PWM_max);

APP = struct('tau_mt', tau_mt,'tau_srv',tau_srv);


