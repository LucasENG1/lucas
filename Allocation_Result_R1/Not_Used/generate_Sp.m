function SP = generate_Sp(T_final,SP_max,dt,Nsim)

for i=1:Nsim
    
    rng shuffle;
    
    Pf = rand*SP_max;
    rng shuffle;
    ti1 = rand*T_final/2;
    tf1 = ti1 + 2;
    P1 = Polinomio(ti1,tf1,0,Pf,0,0,dt,T_final);
    
    rng shuffle;
    td = rand*(T_final-ti1);    
    rng shuffle;
    
    ti2 = tf1 + td;
    tf2 = ti2 + 2;
    P2 = Polinomio(ti2,tf2,0,Pf,0,0,dt,T_final);
    
    SP(i,:)=[P1 - P2];
end
SP(SP<0)=0;
end