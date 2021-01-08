function y = fob_function(x,CTRL_IN)

global k1 Lx Ly 

 Pwm = x(1:4);
 Th  = x(5:8);

M = [k1*cos(Th(1))                        k1*cos(Th(2))                       k1*cos(Th(3))                       k1*cos(Th(4));
     k1*sin(Th(1))                        k1*sin(Th(2))                       k1*sin(Th(3))                       k1*sin(Th(4));
     k1*(-Ly*cos(Th(1))+Lx*sin(Th(1)))  k1*(Ly*cos(Th(2))-Lx*sin(Th(2))) k1*(Ly*cos(Th(3))+Lx*sin(Th(3))) k1*(-Ly*cos(Th(4))-Lx*sin(Th(4)))];

F = M*Pwm;
%%

y = (CTRL_IN - F)'*(CTRL_IN - F);


end
