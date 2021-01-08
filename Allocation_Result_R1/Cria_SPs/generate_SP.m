function SP = generate_SP(T_final,SP_max,dt)

rng shuffle;

Pf = rand*SP_max;
rng shuffle;
ti1 = rand*T_final/3;
tf1 = ti1 + 1;
P1  = Polinomio(ti1,tf1,0,Pf,0,0,dt,T_final);

rng shuffle;
td = rand*(T_final-tf1)/2;

rng shuffle;
ti2 = tf1 + td;
tf2 = ti2 + 1;
P2 = Polinomio(ti2,tf2,0,2*Pf,0,0,dt,T_final);

rng shuffle;
td = rand*(T_final-tf2)/2;

rng shuffle;
ti3 = tf2 + td;
tf3 = ti3 + 1;
P3 = Polinomio(ti3,tf3,0,Pf,0,0,dt,T_final);


SP =[P1 - P2 + P3];
end