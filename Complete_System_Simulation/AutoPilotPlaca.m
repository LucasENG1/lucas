% Tecnica descrita em Performance and Lyapunov Stability of a Nonlinear
% Path-Following Guidance Method
function AutoPilotPlaca(stp)

% Vel = Velocidade Desejada em X
% Global variable(s)
global  Sim SP Sat WP Time;
%% Tecnica
L1 = 1;
P_Controller(stp); % Implementa��o Mathaus

XY = NED2BF(Sim.Current_X_Y_psi(3),[SP.XYZ(1:2,WP);0]-[Sim.Current_X_Y_psi(1:2);0]);
N = atan2(XY(2),XY(1)); %Angulo entre V e o ponto desejado

Sim.Vel(2,stp) = 2*((Sim.Vel(1,stp)^2)/L1)*sin(N); % Acelera��o Lateral em Y
Sim.Vel(3,stp) = 2*(Sim.Vel(1,stp)/L1)*sin(N);%Sim.Vel(2,stp)/Sim.Vel(1,stp);    % Acelera��o em Yaw

if(stp>=length(Time))
    stp = length(Time)-1;
end

%% Satura��es
Sim.Vel(1,stp) = Satura(Sim.Vel(1,stp),Sat.MaxVelX,-Sat.MaxVelX);
Sim.Vel(2,stp) = Satura(Sim.Vel(2,stp),Sat.MaxVelY,-Sat.MaxVelY);
Sim.Vel(3,stp) = Satura(Sim.Vel(3,stp),Sat.MaxVelAng,-Sat.MaxVelAng);

E = norm(SP.XYZ(1:2,WP) - Sim.Current_X_Y_psi(1:2));

if E <1 && WP> (length(SP.XYZ(1,:))-10)
    Sim.Vel(:,stp) = zeros(3,1);
end

end