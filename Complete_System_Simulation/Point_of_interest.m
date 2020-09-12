function Point_of_interest(ROI)
global Sim SP WP;

Erro_X = ROI(1)-Sim.Current_X_Y_psi(1);
Erro_Y = ROI(2)-Sim.Current_X_Y_psi(2);

SP.XYZ(3,WP) = atan2(Erro_Y,Erro_X);

end

