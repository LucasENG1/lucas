function Plot_general(j)

global Sim ROV Sim_Plot SP DEG_TO_RAD WP
PlotBarco(j);
ang = (Sim.Current_X_Y_psi(3));
% Fator de escala
ft = 3;
% motor 1 (superior DIREITO)
XYZ = Rot_pose_motor(ang,(ROV.dcbby),(ROV.Loa/ft));
PlotMotor(Sim.Theta(1,j)*DEG_TO_RAD + ang,Sim.PWM(1,j)*ROV.k1, XYZ + [Sim.Current_X_Y_psi(1:2);0],'1')

% motor 2 (inferior esquerdo)
XYZ = Rot_pose_motor(ang,ROV.dceby,(-ROV.Loa/ft));
PlotMotor(Sim.Theta(2,j)*DEG_TO_RAD+ang,Sim.PWM(2,j)*ROV.k1,XYZ + [Sim.Current_X_Y_psi(1:2);0],'2')

% motor 3 (superior esquerdo)
XYZ = Rot_pose_motor(ang,(ROV.dceby),(ROV.Loa/ft));
PlotMotor(Sim.Theta(3,j)*DEG_TO_RAD+ang,Sim.PWM(3,j)*ROV.k1,XYZ + [Sim.Current_X_Y_psi(1:2);0],'3')

% motor 4 (inferior direito)
XYZ = Rot_pose_motor(ang,ROV.dcbby,(-ROV.Loa/ft));
PlotMotor(Sim.Theta(4,j)*DEG_TO_RAD+ang, Sim.PWM(4,j)*ROV.k1,XYZ + [Sim.Current_X_Y_psi(1:2);0],'4');

hold on
% plot(Kalman.U(1,1:100:i),Kalman.U(2,1:100:i),'b');
% plot(Kalman.Z(1,1:100:i),Kalman.Z(2,1:100:i),'g');
%% SEMPRE QUE PLOTAR POSIÇÃO - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
plot(Sim_Plot.X_Y_psi(2,1:100:j),Sim_Plot.X_Y_psi(1,1:100:j),'r','markersize',2);
hold on
% plot(SP.Y,SP.X,'*g');
plot(SP.XYZ(2,1:WP),SP.XYZ(1,1:WP),'g');% legend('Kalman','Sensor','Real')
hold off
title(sprintf('Tempo: %.2f s FX: %.4f FY: %.4f TN: %.4f\nPosicao: X = %.2f m, Y = %.2f m, yaw = %.2f graus\nVelocidade: u = %.4f m/s, v = %.4f m/s, r = %.4f graus/s',...
    j*Sim.Ts,Sim.F_out(1,j),Sim.F_out(2,j) ,Sim.F_out(3,j), Sim.Current_X_Y_psi(1),Sim.Current_X_Y_psi(2),Sim.Current_X_Y_psi(3)*180/pi,Sim.Current_u_v_r(1),Sim.Current_u_v_r(2),Sim.Current_u_v_r(3)*180/pi));

drawnow

end