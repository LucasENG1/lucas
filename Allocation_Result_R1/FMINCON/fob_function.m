function y = fob_function(x,CTRL_IN)

global k1 k2 k3 k4 Lx Ly 

 Pwm = x(1:4);
 Th  = x(5:8);

M = [cos(Th(1))                         cos(Th(2))                       cos(Th(3))                       cos(Th(4));
     sin(Th(1))                         sin(Th(2))                       sin(Th(3))                       sin(Th(4));
    (-Ly*cos(Th(1))+Lx*sin(Th(1)))  (Ly*cos(Th(2))-Lx*sin(Th(2))) (Ly*cos(Th(3))+Lx*sin(Th(3))) (-Ly*cos(Th(4))-Lx*sin(Th(4)))];

F = M*([k1; k2; k3; k4].*Pwm);
%%

y1 = (CTRL_IN - F);

y = norm(y1);

end
