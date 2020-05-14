function bearing = get_bearing(Loc1, Loc2)
global Sim;
Y = NED2BF(Sim.Current_X_Y_psi(3),[Loc2;0]-[Loc1;0]);
%  Y =Y-[Loc1;0];R
bearing = 0*pi/2 +atan2(Y(2),Y(1));

end 