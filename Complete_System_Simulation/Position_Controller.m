%==========================================================================
% This function implements the controller
%==========================================================================
function Position_Controller(stp)
global Ctrl Sim SP Sat SLC WP;

ErrPXYZ    = (SP.XYZ(:,WP) - Sim.Current_X_Y_psi);
ErrPXYZ(3) = SP.XYZ(3,WP) - abs(Sim.Current_X_Y_psi(3))* sign(Sim.Current_X_Y_psi(3));

ErrIXYZ  = Ctrl.ErrIXYZprev + ((Sim.Ts*SLC.Freq)/2)*(ErrPXYZ+Ctrl.ErrPXYZprev);
Posi_dot = Sim.Current_u_v_r;

Ctrl.ErrPXYZprev = ErrPXYZ;
Ctrl.ErrIXYZprev = ErrIXYZ;

V = Ctrl.kpPosi * ErrPXYZ + Ctrl.kiPosi * ErrIXYZ + Ctrl.kdPosi * Posi_dot;

V(1) = Satura(V(1),Sat.MaxVelX,-Sat.MaxVelX);
V(2) = Satura(V(2),Sat.MaxVelY,-Sat.MaxVelY);
V(3) = Satura(V(3),Sat.MaxVelAng,-Sat.MaxVelAng);

% Rotação de Frame
Sim.Vel(:,stp) = NED2BF(Sim.Current_X_Y_psi(3),V);

end