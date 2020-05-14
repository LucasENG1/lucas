%==========================================================================
% This function implements the controller
%==========================================================================
function P_Controller(stp)
global Ctrl Sim SP Sat WP;
ErrPXYZ    = (SP.XYZ(:,WP) - Sim.Current_X_Y_psi);
V = Ctrl.kpPosi(1,1) * norm(ErrPXYZ) ;
% V = 0.15 * ErrPXYZ ;

V(1) = Satura(V(1),Sat.MaxVelX,-Sat.MaxVelX);
% V(2) = Satura(V(2),Sat.MaxVelY,-Sat.MaxVelY);

Sim.Vel(1,stp) = V;
end







% %==========================================================================
% % This function implements the controller
% %==========================================================================
% function P_Controller(stp)
% % Global variable(s)
% global Sim SP Sat WP Ctrl;
% kPX = 0.15+0*Ctrl.kpPosi(1,1);
% 
% %% Posição NED2BF(Sim.Current_X_Y_psi(3),[SP.XYZ(1:2,WP);0]-[Sim.Current_X_Y_psi(1:2);0])
% % errPX = norm([SP.XYZ(1,WP);SP.XYZ(2,WP)] - [Sim.Current_X_Y_psi(1);Sim.Current_X_Y_psi(2)]);
% errPX = norm(NED2BF(Sim.Current_X_Y_psi(3),[SP.XYZ(1:2,WP);0]-[Sim.Current_X_Y_psi(1:2);0]));
% 
% Vx = 1;%kPX*errPX ;
% 
% Sim.Vel(1,stp) = Satura(Vx,Sat.MaxVelX,-Sat.MaxVelX);
% 
% end