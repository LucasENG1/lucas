clear all; close all; clc
m  = 20.80;
Iz = 2.9824;     % SolidWorks
xG = -0.0500;   % SolidWorks
yG =  0.0000;   % SolidWorks
Xudot= -1.0400;
Xu= -16.3292;
Xv= 0;
Xr= 0;
Xuu= -3.5313;
Yvdot= -17.2552;
Yu= 0;
Yv= -0.0013;
Yr= 0;
Yvv= -48.8006;
Nrdot= -3.7020;
Nu= 0;
Nv= 0;
Nr= -18.9686;
Nrr= -1.1958e-05;
Xvdot= 0;
Xrdot= 0;
Yudot= 0;
Yrdot= 0;
Nudot= 0;
Nvdot= 0;

L = 0.586;
zeta = 1; % Amortecimento
Ts = 1;   % Tempo de Assentamento

Wn = 4/Ts;
%% Controlador P de Posição Angular (P)
VelMax = 2.32; % rad/s
ErrMax = pi/4; % rad

Kp_Vel_Ang = (2.32)/(pi/4)

%% Controlador PD de Posição Angular
%  T = (Iz-Nrdot)/(-Nr);
%  K = 4*L;
%  k = (Wn^2)*T;
%  d = zeta*2*sqrt(k*T);
%  Kp_posi = k/K
%  Kd_posi = (d-1)/K

%% Controlador de Velocidade Angular (PID)
s = tf('s');
 display('VELOCIDADE Angular')
G = (1/(Iz-Nrdot))/(s - Nr/(Iz-Nrdot)); % Planta de controle

% Parametros do controlador
z1 = - Nr/(Iz-Nrdot); % Zero definido para cortar Polo
z2 = 100;             % Zero definido tendendo a infinito (nao interfere posi K esta em função)
Ts = 1;
Kx = 4/(z2*Ts-4);
K  = (Iz-Nrdot)*Kx;

C  = K*(s+z1)*(s+z2)/s; % Controlador
Gc = C*G;
rlocus(Gc);         % Lugar das Raizes em malha aberta
Gc = feedback(Gc,1) % Realimentação unitária

figure
step(Gc);
S = stepinfo(Gc)

%% Controle de Posição Inercial
close all
G = 1/((m-Xudot)*s^2 - Xu*s); % Malha do sistema
rlocus(G);
step(feedback(G,1));
% Ganho do sistema calculado por constrain saturation
Velmax = 300; %cm/s
Rwp = 10; % m
Kp_Vel_X = Velmax/Rwp
 
 %% Controle de Velocidade Inercial 
 display('VELOCIDADE INERCIAL X')
 G = (1/(m-Xudot))/(s - Xu/(m-Xudot)); % Planta de controle

% Parametros do controlador
z1 = - Xu/(m-Xudot); % Zero definido para cortar Polo
z2 = 100; % Zero definido tendendo a infinito (nao interfere posi K esta em função)

Ts = 4;
Kx = 4/(z2*Ts-4);
K  = (m-Xudot)*Kx;

C  = K*(s+z1)*(s+z2)/s % Controlador
Gc = C*G;
rlocus(Gc);         % Lugar das Raizes em malha aberta
Gc = feedback(Gc,1) % Realimentação unitária

figure
step(Gc);
S = stepinfo(Gc)
clc
 display('VELOCIDADE INERCIAL Y')
 G = (1/(m-Yvdot))/(s - Yv/(m-Yvdot)); % Planta de controle

% Parametros do controlador
z1 = - Yv/(m-Yvdot); % Zero definido para cortar Polo
z2 = 50; % Zero definido tendendo a infinito (nao interfere posi K esta em função)

Ts = 2;
Kx = 4/(z2*Ts-4);
K  = (m-Yvdot)*Kx;

C  = K*(s+z1)*(s+z2)/s % Controlador
Gc = C*G;
rlocus(Gc);         % Lugar das Raizes em malha aberta
Gc = feedback(Gc,1) % Realimentação unitária

figure
step(Gc);
S = stepinfo(Gc)
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 