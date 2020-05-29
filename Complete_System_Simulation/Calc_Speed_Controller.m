function [kpVel,kiVel,kdVel] = Calc_Speed_Controller(ts_x,ts_y,ts_yaw)
%% CONTROLADOR PID ===> KD s^2 + KP s + KI
%% Controlador de Velocidade
global ROV;

% Parametros do veículo
m  = ROV.mass;
Iz = ROV.ICG;
s  = tf('s');

%% APROXIMAÇÃO DE 1 ORDEM PARA CALCULO DO CONTROLADOR
% Parametros de massa adicionada
Xu_dot = -2 ;%0*-11.2;
Xu    = -15.8;

Yv_dot = -26; %0*-68.1;
Yv    = -22;

Nr_dot = -8.65; %0*-148.8;
Nr    = -13.2;

%% Malha de Velocidade de guinada
% Gs_psi = (1/(Iz-Nr_dot))/(s-Nr/(Iz-Nr_dot)); % TF em malha aberta

% Controlador PID parametros
timeC = ts_yaw; % tempo de assentamento

z1 = -Nr/(Iz-Nr_dot);
z2 = 10;

ky = 4/(z2*timeC);
kx = ky/(1-ky);
K  = kx*(Iz-Nr_dot);

Cs_yaw = (K*(s+z1)*(s+z2))/s;

[num,den] = tfdata(Cs_yaw,'v');
kDVYaw = num(1);
kPVYaw = num(2);
kIVYaw = num(3);

%% Malha de Velocidade X
% Gs_X = (1/(m-Xu_dot))/(s-Xu/(m-Xu_dot)); % TF em malha aberta

% Controlador PID parametros
timeC = ts_x; % tempo de assentamento

z1 = -Xu/(m-Xu_dot);
z2 = 10;

ky = 4/(z2*timeC);
kx = ky/(1-ky);
K = kx*(m-Xu_dot);

Cs_X = (K*(s+z1)*(s+z2))/s;

[num,den] = tfdata(Cs_X,'v');
kDVX = num(1);
kPVX = num(2);
kIVX = num(3);

%% Malha de Velocidade Y
% Gs_Y = (1/(m-Yv_dot))/(s-Yv/(m-Yv_dot)); % TF em malha aberta

% Controlador PID parametros
timeC = ts_y; % tempo de assentamento

z1 = -Yv/(m-Yv_dot);
z2 = 10;

ky = 4/(z2*timeC);
kx = ky/(1-ky);
K  = kx*(m-Yv_dot);

Cs_Y = (K*(s+z1)*(s+z2))/s;

[num,den] = tfdata(Cs_Y,'v');
kDVY = num(1);
kPVY = num(2);
kIVY = num(3);

kpVel = [kPVX  0     0;
    0    kPVY  0;
    0    0     kPVYaw];

kiVel = [kIVX  0     0;
    0    kIVY  0;
    0    0     kIVYaw];

kdVel = [kDVX  0     0;
    0    kDVY  0;
    0    0     kDVYaw];

end

% GC_Y = Cs_Y*Gs_Y;
%
% figure
% rlocus(GC_Y);
% figure
% step(feedback(GC_Y,1));
% zpk(GC_Y);