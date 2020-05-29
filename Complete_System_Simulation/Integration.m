% RUnge Kutta
function [AuxVector,Aux] = Integration(X,Aux,i)
global Sim 
if(i==1)
    Aux(:,i) =  Sim.Ts*X;
    AuxVector = Aux(:,i);
else
    Aux(:,i)  = Sim.Ts*X;
    AuxVector = (Aux(:,i-1) + 2*(Aux(:,i-1)+Aux(:,i)) + Aux(:,i))/6;
end

AuxVector = [Sim.Current_X_Y_psi;Sim.Current_u_v_r] + AuxVector;

% AuxVector(3) = rem(AuxVector(3),2*pi);
% if AuxVector(3) > pi
%     AuxVector(3) = AuxVector(3) - 2*pi;
% end
% yaw(yaw>pi) = yaw(yaw>pi)-2*pi;
end

