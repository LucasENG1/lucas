function AutoPilot2(stp)

% Vel = Velocidade Desejada em X
% Global variable(s)
global  Sim SP; 

% Sim.Vel(1,1) = 2;

% L1 = norm([SP.X(stp);SP.Y(stp)] - [Sim.Current_X_Y_psi(1);Sim.Current_X_Y_psi(2)]);

% L1 = norm([SP.X(1,stp); SP.Y(1,stp)] - [Sim.Current_X_Y_psi(1);Sim.Current_X_Y_psi(2)]);
 L1 = 1;

XY = NED2BF(Sim.Current_X_Y_psi(3),[SP.X(stp);SP.Y(stp);0]-[Sim.Current_X_Y_psi(1);Sim.Current_X_Y_psi(2);0]);

N = (atan(XY(2)/XY(1)));

AcelY = 2*((Sim.Vel(1,stp)^2)/L1)*sin(N);

Sim.Vel(2,stp) = 1*AcelY;

Sim.Vel(3,stp)  = 1*(Sim.Vel(2,stp)/L1)*sin(N)  ;%AcelY/Sim.Vel(1,stp);

end