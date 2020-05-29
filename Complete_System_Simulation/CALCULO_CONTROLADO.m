close all; clear all; clc;

%% CONTROLADOR PID ===> KD s^2 + KP s + KI
%% Controlador de Posição
% Posição X
Px_umax = 3.05;
Px_umin = 0;
Px_Emax = 10;     %  raio admitido
Px_Emin = 0;     %  raio admitido

display('Posição X')
calcP(Px_umax,Px_umin,Px_Emax,Px_Emin)

% Posição Y
Py_umax = 1.3;
Py_umin = 0;
Py_Emax = 5; %raio admitido
Py_Emin = 0; %raio admitido

display('Posição Y')
calcP(Py_umax,Py_umin,Py_Emax,Py_Emin)

% Posição de guinada
Psi_umax = 2.32; % radianos
Psi_umin = 0;
Psi_Emax = pi/4; % radianos
Psi_Emin = 0; %raio admitido

display('Posição de guinada')
calcP(Psi_umax,Psi_umin,Psi_Emax,Psi_Emin)

%% Controlador de Velocidade
% Parametros do veículo
m = 20.8;
Iz = 2.98;

% Parametros Estimados
Xu_dot = -2;
Xu  = -15.8;
Xuu = -7.3*0;

Yv_dot = -26;
Yr_dot = -0;
Yv = -22;
Yr = -0;
Yvv = -0;

Nv  = 0;
Nv_dot = 0;

Nr_dot = -8.65;
Nr  = -13.2;
Nrr = 0;

s = tf('s');


%% Malha de Velocidade de guinada
display('Velocidade de guinada')
Gs_psi = (1/(Iz-Nr_dot))/(s-Nr/(Iz-Nr_dot)); % TF em malha aberta

% Controlador PID parametros
timeC = 13.50; % tempo de assentamento

z1 = -Nr/(Iz-Nr_dot);
z2 = 10;

ky = 4/(z2*timeC);
kx = ky/(1-ky);
K  = kx*(Iz-Nr_dot);

Cs_yaw = (K*(s+z1)*(s+z2))/s

GC = Cs_yaw*Gs_psi;

rlocus(GC);
figure
step(feedback(GC,1));
zpk(Cs_yaw);

%% Malha de Velocidade X
display('Velocidade X')

Gs_X = (1/(m-Xu_dot))/(s-Xu/(m-Xu_dot)); % TF em malha aberta

% Controlador PID parametros
timeC = 2; % tempo de assentamento

z1 = -Xu/(m-Xu_dot);
z2 = 10;

ky = 4/(z2*timeC);
kx = ky/(1-ky);
K = kx*(m-Xu_dot);

Cs_X = (K*(s+z1)*(s+z2))/s

GC_X = Cs_X*Gs_X;

figure
rlocus(GC_X);
figure
step(feedback(GC_X,1));
zpk(GC_X);

%% Malha de Velocidade Y
display('Velocidade Y')

Gs_Y = (1/(m-Yv_dot))/(s-Yv/(m-Yv_dot)); % TF em malha aberta

% Controlador PID parametros
timeC = 2; % tempo de assentamento

z1 = -Yv/(m-Yv_dot);
z2 = 10;

ky = 4/(z2*timeC);
kx = ky/(1-ky);
K = kx*(m-Yv_dot);

Cs_Y = (K*(s+z1)*(s+z2))/s

GC_Y = Cs_Y*Gs_Y;

figure
rlocus(GC_Y);
figure
step(feedback(GC_Y,1));
zpk(GC_Y);


% Definição de Funções
function P = calcP(Fmax,Fmin,Emax,Emin)

P = (Fmax-Fmin)/(Emax-Emin);


end