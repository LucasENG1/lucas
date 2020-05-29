%===========================================================================
% This function computes the Hydrodynamic Resistance D(v)v acting on the ROV
%===========================================================================
function [Results] = Hydro_Resist()
global ROV Sim;

% Parametros de amortecimento linear
Xu = ROV.Xu;
Yv = ROV.Yv;
Yr = ROV.Yr;
Nv = ROV.Nv;
Nr = ROV.Nr;

% Parametros de amortecimento não linear
Xuu = ROV.Xuu;
Yvv = ROV.Yvv;
Yvr = ROV.Yvr;
Nvv = ROV.Nvv;
Nvr = ROV.Nvr;

% Velocidades
ur = Sim.Current_u_v_r(1);
vr = Sim.Current_u_v_r(2);
r  = Sim.Current_u_v_r(3);

%%  Matriz de amortecimento

% Equação 7.19 -- Fossen
D_lin = -[ Xu      0       0; 
            0     Yv      Yr; 
            0     Nv      Nr];

% Equação 7.24 -- Fossen Aproximação aceitavel
D_non_lin = - [ Xuu*abs(ur)      0            0;
                    0       Yvv*abs(vr)    Yvr*abs(vr);
                    0       Nvv*abs(vr)    Nvr*abs(vr)];

% Equação 6.57 -- Fossen
DV = D_lin + D_non_lin;                      

%%
% Parte da Equação 8.1 -- Fossen
Results = DV*Sim.Current_u_v_r;

end