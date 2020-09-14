function Point_of_interest(POI) 
%%Direciona o controle de yaw para olhar sempre para o ponto escolhido
global Sim SP WP;

Erro_X = POI(1)-Sim.Current_X_Y_psi(1);
Erro_Y = POI(2)-Sim.Current_X_Y_psi(2);

psi = atan2(Erro_Y,Erro_X);

Delta = psi - Sim.Current_X_Y_psi(3);

if Delta >pi
    Delta = Delta - 2*pi;
end
if Delta < -pi
    Delta =Delta + 2*pi;
end

SP.XYZ(3,WP) = Sim.Current_X_Y_psi(3)+Delta;
end

