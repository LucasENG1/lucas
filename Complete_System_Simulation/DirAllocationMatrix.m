function F = DirAllocationMatrix(PWM,Theta)
%% alocação do barco
global ROV k1;
% Angulo dos braços do barco em relaçao ao centro
phi = pi/4 ;
L  = ROV.L;
Lx = L*cos(phi);
Ly = L*sin(phi);

F = [k1*(PWM(1)*cos(Theta(1))+PWM(2)*cos(Theta(2))+PWM(3)*cos(Theta(3))+PWM(4)*cos(Theta(4)));
     k1*(PWM(1)*sin(Theta(1))+PWM(2)*sin(Theta(2))+PWM(3)*sin(Theta(3))+PWM(4)*sin(Theta(4)));
     k1*(Lx*(-PWM(1)*cos(Theta(1))+PWM(2)*cos(Theta(2))+PWM(3)*cos(Theta(3))-PWM(4)*cos(Theta(4))) + Ly*(PWM(1)*sin(Theta(1))-PWM(2)*sin(Theta(2))+PWM(3)*sin(Theta(3))-PWM(4)*sin(Theta(4))))];

end