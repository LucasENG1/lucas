function F = Aloc_DiretaSAE(theta,Pwm)
% Angulo em Radianos
global k1 Lx Ly DEG_TO_RAD Sat;

Pwm = NormtoPWM(Pwm);
Th  = theta.* DEG_TO_RAD;

M =   [1   1   1   1   -1   -1;
       0   0   0   0    0    0;
      -Ly  Ly  Ly -Ly -Ly  Ly];

F = M*Pwm.*k1;

F(1) = Satura(F(1),Sat.F_motor,-Sat.F_motor);
F(2) = Satura(F(2),Sat.F_motor,-Sat.F_motor);
F(3) = Satura(F(3),Sat.torque,-Sat.torque);
end