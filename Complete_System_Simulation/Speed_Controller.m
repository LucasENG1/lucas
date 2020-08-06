%==========================================================================
% This function implements the Speed Controller no BF
%==========================================================================
function Speed_Controller(i,j)
global Ctrl Sim Sat;

ErrPVXYZ  = (Sim.Vel(:,i) - Sim.Current_u_v_r);

ErrIVXYZ  = Ctrl.ErrIVXYZprev + (Sim.Ts/2)*(ErrPVXYZ+Ctrl.ErrPVXYZprev);
Vel_dot   = Sim.u_v_r_dot(:,j);

Ctrl.ErrPVXYZprev = ErrPVXYZ;
Ctrl.ErrIVXYZprev = ErrIVXYZ;

F = Ctrl.kpVel * ErrPVXYZ + Ctrl.kiVel * ErrIVXYZ + Ctrl.kdVel * Vel_dot;

F(1) = Satura(F(1),Sat.F_motor,-Sat.F_motor);
F(2) = Satura(F(2),Sat.F_motor,-Sat.F_motor);
F(3) = Satura(F(3),Sat.torque,-Sat.torque);

Sim.F(:,j) = F;

end