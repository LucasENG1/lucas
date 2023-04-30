function Line_of_sight(stp)
% Vel = Velocidade Desejada em X
global  Sim  SP Time SLC WP Sat;

% P_Controller(stp); % Implementação Mathaus

XY = NED2BF(Sim.Current_X_Y_psi(3),[SP.XYZ(1:2,WP);0]-[Sim.Current_X_Y_psi(1:2);0]);
N  = atan2(XY(2),XY(1)); % Angulo entre V e o ponto desejado

Sim.Vel(1,stp) = 1.5*norm(Sim.Vel(1:2,stp));%norm(NED2BF(Sim.Current_X_Y_psi(3),[Sim.Vel(1:2,stp);0]));
% Sim.Vel(1,stp) = norm(XY);
Sim.Vel(2,stp) = 0;
Sim.Vel(3,stp) = 0.5*N;

if(stp>=length(Time))
    stp = length(Time)-1;
end

%% Saturação
Sim.Vel(1,stp) = Satura(Sim.Vel(1,stp),Sat.MaxVelX,-Sat.MaxVelX);
Sim.Vel(2,stp) = Satura(Sim.Vel(2,stp),Sat.MaxVelY,-Sat.MaxVelY);
Sim.Vel(3,stp) = Satura(Sim.Vel(3,stp),Sat.MaxVelAng,-Sat.MaxVelAng);

% SP.XYZ(3,WP) = rem(SP.XYZ(3,WP),2*pi);

%---------------------------------------------
E = norm(SP.XYZ(1:2,end) - Sim.Current_X_Y_psi(1:2));

% if E <1 && WP>= length(SP.XYZ(1,:))
%     Sim.Vel(:,stp) = zeros(3,1);
% end

V            =  Sim.Vel(3,stp) * (SLC.Freq*Sim.Ts)/2 ;
SP.XYZ(3,WP) = SP.XYZ(3,WP-1)+V;
end