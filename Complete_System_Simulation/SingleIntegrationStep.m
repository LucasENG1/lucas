%==========================================================================
% This function implements a double integrator that performs a single inte-
% gration step using one of the available numerical integration methods. It
% also handles the condition when the airplane is on the ground
%==========================================================================

function [AuxVector] = SingleIntegrationStep(F_X)

% Global variable(s)
global Sim Torque ROV;

IntMethod = 2;
if IntMethod == 0
    % Method 1: Forward Euler method
    AuxVector = Sim.Ts*F_X;
    
elseif IntMethod == 1
%     M = ROV.IMra;
%     h = Sim.Ts;
%     C = Coriolis_Effect_Cat;
%     D = Hydro_Resist;
%     
%     Tal = Torque;
%     k1 = h*(M^(-1))*(Tal-D-C*Sim.Current_u_v_r);
%     aux = Sim.Current_u_v_r + k1/2;
%     
%     C = matrizC(aux);
%     D = matrizD(aux);
%     Tal = propulsao(P,n);
%     k2 = h*(M^(-1))*(Tal-D-C*aux);
%     aux = Xk + k2/2;
%     
%     C = matrizC(aux);
%     D = matrizD(aux);
%     Tal = propulsao(P,n);
%     k3 = h*(M^(-1))*(Tal-D-C*aux);
%     aux = Xk + k3;
%     
%     C = matrizC(aux);
%     D = matrizD(aux);
%     Tal = propulsao(P,n);
%     k4 = h*(M^(-1))*(Tal-D-C*aux);
%     
%     Xkk = Xk + (1/6)*( k1 + 2*k2 + 2*k3 + k4);
else
    
    % Method 2: Explicit 4th-order Runge-Kutta method (default)
    s1 = F_X;
    s2 = F_X + (Sim.Ts/3)*s1;
    s3 = F_X + 2*(Sim.Ts/3)*s2;
    s4 = F_X + Sim.Ts*s3;
    
    AuxVector = (Sim.Ts/8)*(s1 + 3*s2 + 3*s3 + s4);
end

% Accumulates by adding the newest computed value (1 step ahead)

% Both vectors (double integration) are splitted

% posAndAtt    = AuxVector(1:3);
% linAndAngVel = AuxVector(4:6);

end

