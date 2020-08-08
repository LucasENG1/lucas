function F = Aloc_Direta(theta,Pwm)
% Angulo em Radianos
global k1 Lx Ly DEG_TO_RAD Sat;

Pwm = NormtoPWM(Pwm);
Th  = theta.* DEG_TO_RAD;

M = [cos(Th(1))                         cos(Th(2))                       cos(Th(3))                       cos(Th(4));
     sin(Th(1))                         sin(Th(2))                       sin(Th(3))                       sin(Th(4));
    (-Ly*cos(Th(1))+Lx*sin(Th(1)))  (Ly*cos(Th(2))-Lx*sin(Th(2))) (Ly*cos(Th(3))+Lx*sin(Th(3))) (-Ly*cos(Th(4))-Lx*sin(Th(4)))];

F = M*Pwm.*k1;

F(1) = Satura(F(1),Sat.F_motor,-Sat.F_motor);
F(2) = Satura(F(2),Sat.F_motor,-Sat.F_motor);
F(3) = Satura(F(3),Sat.torque,-Sat.torque);
end