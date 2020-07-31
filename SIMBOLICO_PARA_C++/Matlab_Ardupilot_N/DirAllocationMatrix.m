function F = DirAllocationMatrix(PWM,Theta)

global k1 k2 k3 k4 Lx Ly


%% alocação do barco
F = [PWM(1)*k1*cos(Theta(1)) + PWM(2)*k2*cos(Theta(2)) + PWM(3)*k3*cos(Theta(3)) + PWM(4)*k4*cos(Theta(4));
     PWM(1)*k1*sin(Theta(1)) + PWM(2)*k2*sin(Theta(2)) + PWM(3)*k3*sin(Theta(3)) + PWM(4)*k4*sin(Theta(4));
     Lx*(PWM(1)*k1*sin(Theta(1)) - PWM(2)*k2*sin(Theta(2)) + PWM(3)*k3*sin(Theta(3)) - PWM(4)*k4*sin(Theta(4)))-Ly*(PWM(1)*k1*cos(Theta(1)) - PWM(2)*k2*cos(Theta(2)) - PWM(3)*k3*cos(Theta(3)) + PWM(4)*k4*cos(Theta(4)))];
end