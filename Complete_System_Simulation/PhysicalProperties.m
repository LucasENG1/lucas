%==========================================================================
% CATAMARAN MODEL PARAMETERS
%==========================================================================
function PhysicalProperties
% Global variable(s)
global ROV APP Lx Ly k1 Sat Pwmmax Pwmmin Fmax Nmax;

% PARAMETROS A SEREM DEFINIDOS - Saturacao
MaxVelX   = 3.05;
MaxVelY   = 1;
MaxVelAng = 2.32; %rad/s

WpRadius  = 3;

% Parametros construtivos
m   = 20.8;
xg  = -0.05;
Iz  = 2.9824;
L   = 0.586;

Fmax = 2.1*9.81*4; % Força maxíma real
Nmax = L*Fmax;

Pwmmax = 1001.0;
Pwmmin = 1.0;

Lx = L*cos(pi/4.0);
Ly = L*cos(pi/4.0);
k1 = (Fmax/4.0)/(Pwmmax-Pwmmin);

%% Parametros relacionados ao desenho (plot) do barco
Loa   =   1.40;             % Comprimento do casco (metros)
dcx   =  Loa/2;
Bw1   =   0.20;              % Largura da linha dágua [m]
dcbby =  Lx - Bw1/2;
dceby = -dcbby;

%% MODELO COMPLETO PARA UTILIZAÇÃO NA SIMULAÇÃO
Xudot = -1.0400;
Xu    = -16.3292;
% Xv    = 0;
% Xr    = 0;
Xuu   = -3.5313;
Yvdot = -17.2552;
% Yu    = 0;
Yv    = -0.0013;
Yr    = 0;
Yvv   = -48.8006;
Nrdot = -3.7020;
% Nu    = 0;
Nv    = 0;
Nr    = -18.9686;
Nrr   = -1.1958e-05;
% Xvdot = 0;
% Xrdot = 0;
% Yudot = 0;
Yrdot = 0;
% Nudot = 0;
% Nvdot = 0;
Yvr   = 0;
Nrv   = 0;
Nvv   = 0;
Nvr   = 0;

%% APROXIMAÇÃO DE 1 ORDEM PARA CALCULO DO CONTROLADOR
% % Parametros de massa adicionada
% Xudot = -2 ;%0*-11.2;
% Xu    = -15.8;
% Xuu   =  0; 
% 
% Yvdot = -26; %0*-68.1;
% Yv    = -22;
% Yvv   =  0;   
% 
% Nrdot = -8.65; %0*-148.8;
% Nr    = -13.2;
% Nrr   =   0;
% 
% Yrdot =   0;
% Yr    =   0;
% Yvr   =   0;    
% Nv    =   0;
% Nrv   =   0;
% Nvv   =   0;
% Nvr   =   0;

%% Momentos e produtos de Inércia
CG = [xg;0;0];

% Matriz de massa de corpo rígido   6.7 --- 7.12
IMrb = [ m       0       0; 
         0       m    m*xg; 
         0    m*xg      Iz];

% Matrix de massa adicionada    6.50 -- 7.14
IMra =  [ -Xudot    0         0; 
          0     -Yvdot    -Yrdot; 
          0     -Yrdot    -Nrdot]; 

%% Matriz de massa
IM = IMrb + IMra;                 % 6.48    7.8     

%% Constante de Tempo
settling_time_mt  = 0.03;
settling_time_srv = 0.05;

tau_mt  = settling_time_mt/5;    % Motors
tau_srv = settling_time_srv/5;   % Servos

Sat = struct('F_motor',Fmax,'torque', Nmax,'MaxVelX',MaxVelX,'MaxVelY',MaxVelY,'MaxVelAng',MaxVelAng);

ROV = struct('mass',m,'ICG',Iz,'InertiaMatrix',IM,'IMrb',IMrb,'IMra',IMra,...
    'InverseInertia',inv(IM),'Xudot',Xudot,'Yvdot',Yvdot,'Yrdot',Yrdot,...
    'Nrdot',Nrdot,'Xuu', Xuu,'Yvv',Yvv,'Yvr',Yvr,'Nrv',Nrv,'Nvv',Nvv,...
    'Nvr', Nvr, 'Nrr', Nrr,'Xu', Xu, 'Yv', Yv, 'Yr', Yr, 'Nv', Nv,...
    'Nr', Nr, 'dcx', dcx,'dcbby', dcbby, 'dceby', dceby, 'CG', CG,...
    'Bw1',Bw1,'Loa',Loa,'Lx',Lx,'Ly',Ly,'k1',k1,'WpRadius',WpRadius);

APP = struct('tau_mt', tau_mt,'tau_srv',tau_srv);
end