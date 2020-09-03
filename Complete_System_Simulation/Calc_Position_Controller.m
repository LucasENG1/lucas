function [kpPosi,kiPosi,kdPosi] = Calc_Position_Controller()
%% Controlador de Posi��o
global Sat ;
Raio = 10;

% Posi��o X
Px_umax = Sat.MaxVelX;
Px_umin = 0;
Px_Emax = Raio;    %  raio admitido
Px_Emin = 0;       %  raio admitido

kPX = calc_P_Gain(Px_umax,Px_umin,Px_Emax,Px_Emin);

% Posi��o Y
Py_umax = Sat.MaxVelY;
Py_umin = 0;
Py_Emax = Raio/2; %raio admitido
Py_Emin = 0; %raio admitido

kPY = calc_P_Gain(Py_umax,Py_umin,Py_Emax,Py_Emin);

% Posi��o de guinada
Psi_umax = Sat.MaxVelAng; % radianos
Psi_umin = 0;
Psi_Emax = pi/4; % radianos
Psi_Emin = 0;    % raio admitido

kPYaw = calc_P_Gain(Psi_umax,Psi_umin,Psi_Emax,Psi_Emin);

% Posi��o X
       kIX =  0;       kDX =  0;
% Posi��o Y
       kIY =  0;       kDY =  0;
% Posi��o Guinada
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


% Defini��o de Fun��es
function P = calc_P_Gain(Fmax,Fmin,Emax,Emin)

P = (Fmax-Fmin)/(Emax-Emin);

end