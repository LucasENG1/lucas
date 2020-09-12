function [kpPosi,kiPosi,kdPosi] = Calc_Position_Controller(Raio)
%% Controlador de Posição
global Sat ;
% Raio = 3;

%% Posição X
Px_umax = Sat.MaxVelX;
Px_umin = 0;
Px_Emax = Raio;    %  raio admitido
Px_Emin = 0;       %  raio admitido

kPX = calc_P_Gain(Px_umax,Px_umin,Px_Emax,Px_Emin);

%% Posição Y
Py_umax = Sat.MaxVelY;
Py_umin = 0;
Py_Emax = Raio/10; %raio admitido
Py_Emin = 0; %raio admitido

kPY = calc_P_Gain(Py_umax,Py_umin,Py_Emax,Py_Emin);

%% Posição de guinada
Psi_umax = Sat.MaxVelAng; % radianos
Psi_umin = 0;
Psi_Emax = pi/4; % radianos
Psi_Emin = 0;    % raio admitido

kPYaw = calc_P_Gain(Psi_umax,Psi_umin,Psi_Emax,Psi_Emin);

% Posição X
       kIX =  0.0;       kDX =  0;
% Posição Y
       kIY =  0.0;       kDY =  0;
% Posição Guinada
       kIYaw = 0;      kDYaw = 0;

kpPosi = [kPX 0    0 ;
          0   kPY  0 ;
          0   0    kPYaw];
      
kiPosi = [kIX 0    0 ;
          0   kIY  0 ;
          0   0    kIYaw];
      
kdPosi = [kDX 0    0 ;
          0   kDY  0 ;
          0   0    kDYaw];
end


% Definição de Funções
function P = calc_P_Gain(Fmax,Fmin,Emax,Emin)

P = (Fmax-Fmin)/(Emax-Emin);

end