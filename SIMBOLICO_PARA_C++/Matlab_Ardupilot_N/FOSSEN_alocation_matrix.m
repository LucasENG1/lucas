function [PWM,Theta,Erro,F] = FOSSEN_alocation_matrix(FX,FY,TN, PWM, Theta)

global Fmax Nmax k1 k2 k3 k4 M_PI RAD_TO_DEG Lx Ly Pwmmax Pwmmin L

FX = constrain_float(FX,-Fmax,Fmax);
FY = constrain_float(FY,-Fmax,Fmax);
TN = constrain_float(TN,-Nmax,Nmax);

Err = 100;
F = zeros(3,1);

PWM1 = (PWM(1));
PWM2 = (PWM(2));
PWM3 = (PWM(3));
PWM4 = (PWM(4));

Th1 = Theta(1);
Th2 = Theta(2);
Th3 = Theta(3);
Th4 = Theta(4);

aux  = 0;
g = 0;
while(Err>1 && aux < 1)
    aux = aux +1;
    
    %=============================== Arco seno do angulo calculado a partir da força e do novo PWM ===============================
   
% Th1 = atan2((TN*(Lx*PWM1*sq(PWM2) + Lx*PWM1*sq(PWM4)))/(2*k1*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) + (FY*(sq(Lx)*PWM1*powf(PWM2,4) + sq(Lx)*PWM1*powf(PWM4,4) + sq(Lx)*powf(PWM1,3)*sq(PWM2) + sq(Lx)*powf(PWM1,3)*sq(PWM4) + 2*sq(Ly)*powf(PWM1,3)*sq(PWM2) + 2*sq(Ly)*powf(PWM1,3)*sq(PWM3) + sq(Lx)*PWM1*sq(PWM2)*sq(PWM3) + 2*sq(Lx)*PWM1*sq(PWM2)*sq(PWM4) + sq(Lx)*PWM1*sq(PWM3)*sq(PWM4) + 2*sq(Ly)*PWM1*sq(PWM2)*sq(PWM4) + 2*sq(Ly)*PWM1*sq(PWM3)*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) + (FX*(Lx*PWM1*sq(PWM2) + Lx*PWM1*sq(PWM4))*(Ly*sq(PWM1) - Ly*sq(PWM2) - Ly*sq(PWM3) + Ly*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))), (FX*(sq(Ly)*PWM1*powf(PWM2,4) + sq(Ly)*PWM1*powf(PWM3,4) + 2*sq(Lx)*powf(PWM1,3)*sq(PWM2) + 2*sq(Lx)*powf(PWM1,3)*sq(PWM4) + sq(Ly)*powf(PWM1,3)*sq(PWM2) + sq(Ly)*powf(PWM1,3)*sq(PWM3) + 2*sq(Lx)*PWM1*sq(PWM2)*sq(PWM3) + 2*sq(Lx)*PWM1*sq(PWM3)*sq(PWM4) + 2*sq(Ly)*PWM1*sq(PWM2)*sq(PWM3) + sq(Ly)*PWM1*sq(PWM2)*sq(PWM4) + sq(Ly)*PWM1*sq(PWM3)*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) - (TN*(Ly*PWM1*sq(PWM2) + Ly*PWM1*sq(PWM3)))/(2*k1*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) + (FY*(Ly*PWM1*sq(PWM2) + Ly*PWM1*sq(PWM3))*(Lx*sq(PWM1) - Lx*sq(PWM2) + Lx*sq(PWM3) - Lx*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))));
% Th2 = atan2((FY*(sq(Lx)*powf(PWM1,4)*PWM2 + sq(Lx)*PWM2*powf(PWM3,4) + sq(Lx)*sq(PWM1)*powf(PWM2,3) + sq(Lx)*powf(PWM2,3)*sq(PWM3) + 2*sq(Ly)*sq(PWM1)*powf(PWM2,3) + 2*sq(Ly)*powf(PWM2,3)*sq(PWM4) + 2*sq(Lx)*sq(PWM1)*PWM2*sq(PWM3) + sq(Lx)*sq(PWM1)*PWM2*sq(PWM4) + sq(Lx)*PWM2*sq(PWM3)*sq(PWM4) + 2*sq(Ly)*sq(PWM1)*PWM2*sq(PWM3) + 2*sq(Ly)*PWM2*sq(PWM3)*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) - (TN*(Lx*sq(PWM1)*PWM2 + Lx*PWM2*sq(PWM3)))/(2*k1*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) - (FX*(Lx*sq(PWM1)*PWM2 + Lx*PWM2*sq(PWM3))*(Ly*sq(PWM1) - Ly*sq(PWM2) - Ly*sq(PWM3) + Ly*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))), (TN*(Ly*sq(PWM1)*PWM2 + Ly*PWM2*sq(PWM4)))/(2*k1*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) + (FX*(sq(Ly)*powf(PWM1,4)*PWM2 + sq(Ly)*PWM2*powf(PWM4,4) + 2*sq(Lx)*sq(PWM1)*powf(PWM2,3) + 2*sq(Lx)*powf(PWM2,3)*sq(PWM3) + sq(Ly)*sq(PWM1)*powf(PWM2,3) + sq(Ly)*powf(PWM2,3)*sq(PWM4) + 2*sq(Lx)*sq(PWM1)*PWM2*sq(PWM4) + 2*sq(Lx)*PWM2*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*PWM2*sq(PWM3) + 2*sq(Ly)*sq(PWM1)*PWM2*sq(PWM4) + sq(Ly)*PWM2*sq(PWM3)*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) - (FY*(Ly*sq(PWM1)*PWM2 + Ly*PWM2*sq(PWM4))*(Lx*sq(PWM1) - Lx*sq(PWM2) + Lx*sq(PWM3) - Lx*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))));
% Th3 = atan2((TN*(Lx*sq(PWM2)*PWM3 + Lx*PWM3*sq(PWM4)))/(2*k1*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) + (FY*(sq(Lx)*powf(PWM2,4)*PWM3 + sq(Lx)*PWM3*powf(PWM4,4) + sq(Lx)*sq(PWM2)*powf(PWM3,3) + sq(Lx)*powf(PWM3,3)*sq(PWM4) + 2*sq(Ly)*sq(PWM1)*powf(PWM3,3) + 2*sq(Ly)*powf(PWM3,3)*sq(PWM4) + sq(Lx)*sq(PWM1)*sq(PWM2)*PWM3 + sq(Lx)*sq(PWM1)*PWM3*sq(PWM4) + 2*sq(Lx)*sq(PWM2)*PWM3*sq(PWM4) + 2*sq(Ly)*sq(PWM1)*sq(PWM2)*PWM3 + 2*sq(Ly)*sq(PWM2)*PWM3*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) + (FX*(Lx*sq(PWM2)*PWM3 + Lx*PWM3*sq(PWM4))*(Ly*sq(PWM1) - Ly*sq(PWM2) - Ly*sq(PWM3) + Ly*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))), (TN*(Ly*sq(PWM1)*PWM3 + Ly*PWM3*sq(PWM4)))/(2*k1*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) + (FX*(sq(Ly)*powf(PWM1,4)*PWM3 + sq(Ly)*PWM3*powf(PWM4,4) + 2*sq(Lx)*sq(PWM2)*powf(PWM3,3) + 2*sq(Lx)*powf(PWM3,3)*sq(PWM4) + sq(Ly)*sq(PWM1)*powf(PWM3,3) + sq(Ly)*powf(PWM3,3)*sq(PWM4) + 2*sq(Lx)*sq(PWM1)*sq(PWM2)*PWM3 + 2*sq(Lx)*sq(PWM1)*PWM3*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2)*PWM3 + 2*sq(Ly)*sq(PWM1)*PWM3*sq(PWM4) + sq(Ly)*sq(PWM2)*PWM3*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) - (FY*(Ly*sq(PWM1)*PWM3 + Ly*PWM3*sq(PWM4))*(Lx*sq(PWM1) - Lx*sq(PWM2) + Lx*sq(PWM3) - Lx*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))));
% Th4 = atan2((FY*(sq(Lx)*powf(PWM1,4)*PWM4 + sq(Lx)*powf(PWM3,4)*PWM4 + sq(Lx)*sq(PWM1)*powf(PWM4,3) + sq(Lx)*sq(PWM3)*powf(PWM4,3) + 2*sq(Ly)*sq(PWM2)*powf(PWM4,3) + 2*sq(Ly)*sq(PWM3)*powf(PWM4,3) + sq(Lx)*sq(PWM1)*sq(PWM2)*PWM4 + 2*sq(Lx)*sq(PWM1)*sq(PWM3)*PWM4 + sq(Lx)*sq(PWM2)*sq(PWM3)*PWM4 + 2*sq(Ly)*sq(PWM1)*sq(PWM2)*PWM4 + 2*sq(Ly)*sq(PWM1)*sq(PWM3)*PWM4))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) - (TN*(Lx*sq(PWM1)*PWM4 + Lx*sq(PWM3)*PWM4))/(2*k1*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) - (FX*(Lx*sq(PWM1)*PWM4 + Lx*sq(PWM3)*PWM4)*(Ly*sq(PWM1) - Ly*sq(PWM2) - Ly*sq(PWM3) + Ly*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))), (FX*(sq(Ly)*powf(PWM2,4)*PWM4 + sq(Ly)*powf(PWM3,4)*PWM4 + 2*sq(Lx)*sq(PWM1)*powf(PWM4,3) + 2*sq(Lx)*sq(PWM3)*powf(PWM4,3) + sq(Ly)*sq(PWM2)*powf(PWM4,3) + sq(Ly)*sq(PWM3)*powf(PWM4,3) + 2*sq(Lx)*sq(PWM1)*sq(PWM2)*PWM4 + 2*sq(Lx)*sq(PWM2)*sq(PWM3)*PWM4 + sq(Ly)*sq(PWM1)*sq(PWM2)*PWM4 + sq(Ly)*sq(PWM1)*sq(PWM3)*PWM4 + 2*sq(Ly)*sq(PWM2)*sq(PWM3)*PWM4))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) - (TN*(Ly*sq(PWM2)*PWM4 + Ly*sq(PWM3)*PWM4))/(2*k1*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))) + (FY*(Ly*sq(PWM2)*PWM4 + Ly*sq(PWM3)*PWM4)*(Lx*sq(PWM1) - Lx*sq(PWM2) + Lx*sq(PWM3) - Lx*sq(PWM4)))/(2*k1*(sq(PWM1) + sq(PWM2) + sq(PWM3) + sq(PWM4))*(sq(Lx)*sq(PWM1)*sq(PWM2) + sq(Lx)*sq(PWM1)*sq(PWM4) + sq(Lx)*sq(PWM2)*sq(PWM3) + sq(Lx)*sq(PWM3)*sq(PWM4) + sq(Ly)*sq(PWM1)*sq(PWM2) + sq(Ly)*sq(PWM1)*sq(PWM3) + sq(Ly)*sq(PWM2)*sq(PWM4) + sq(Ly)*sq(PWM3)*sq(PWM4))));
% 
%     %========================================== PWM calculado a partir da força e dos angulos ===================================
% PWM1 = (1501000*FX*cos(Th1) + 1501000*FY*sin(Th1) - 500000*FX*cos(Th1 - 2*Th2) - 500000*FX*cos(Th1 - 2*Th3) - 500000*FX*cos(Th1 - 2*Th4) + 500000*FY*sin(Th1 - 2*Th2) + 500000*FY*sin(Th1 - 2*Th3) + 500000*FY*sin(Th1 - 2*Th4) + 2001500000*FX*sq(Lx)*cos(Th1) + 2002000000*FX*sq(Ly)*cos(Th1) + 2002000000*FY*sq(Lx)*sin(Th1) + 2001500000*FY*sq(Ly)*sin(Th1) - 500000000*FX*sq(Lx)*cos(Th1 - 2*Th2) - 500500000*FX*sq(Lx)*cos(Th1 + 2*Th2) - 2000500000*FX*sq(Lx)*cos(Th1 - 2*Th3) - 500000000*FX*sq(Lx)*cos(Th1 - 2*Th4) - 500500000*FX*sq(Lx)*cos(Th1 + 2*Th4) + 500000*FX*sq(Ly)*cos(Th1 - 2*Th2) + 500500000*FX*sq(Ly)*cos(Th1 + 2*Th2) + 500000*FX*sq(Ly)*cos(Th1 - 2*Th3) + 500500000*FX*sq(Ly)*cos(Th1 + 2*Th3) - 1000000000*FX*sq(Ly)*cos(Th1 - 2*Th4) - 500000*FY*sq(Lx)*sin(Th1 - 2*Th2) - 500500000*FY*sq(Lx)*sin(Th1 + 2*Th2) + 1000000000*FY*sq(Lx)*sin(Th1 - 2*Th3) - 500000*FY*sq(Lx)*sin(Th1 - 2*Th4) - 500500000*FY*sq(Lx)*sin(Th1 + 2*Th4) + 500000000*FY*sq(Ly)*sin(Th1 - 2*Th2) + 500500000*FY*sq(Ly)*sin(Th1 + 2*Th2) + 500000000*FY*sq(Ly)*sin(Th1 - 2*Th3) + 500500000*FY*sq(Ly)*sin(Th1 + 2*Th3) + 2000500000*FY*sq(Ly)*sin(Th1 - 2*Th4) + 500000000*FX*sq(Lx)*cos(2*Th2 - Th1 + 2*Th3) + 500000000*FX*sq(Lx)*cos(2*Th3 - Th1 + 2*Th4) - 500000000*FX*sq(Ly)*cos(2*Th2 - Th1 + 2*Th4) - 500000000*FX*sq(Ly)*cos(2*Th3 - Th1 + 2*Th4) + 500000000*FY*sq(Lx)*sin(2*Th2 - Th1 + 2*Th3) + 500000000*FY*sq(Lx)*sin(2*Th3 - Th1 + 2*Th4) - 500000000*FY*sq(Ly)*sin(2*Th2 - Th1 + 2*Th4) - 500000000*FY*sq(Ly)*sin(2*Th3 - Th1 + 2*Th4) + 500000000*Ly*TN*cos(Th1 - 2*Th2 + 2*Th3) + 500000000*Ly*TN*cos(Th1 + 2*Th2 - 2*Th3) + 500000000*Ly*TN*cos(Th1 + 2*Th2 - 2*Th4) + 500000000*Ly*TN*cos(Th1 + 2*Th3 - 2*Th4) - 500000000*Lx*TN*sin(Th1 + 2*Th2 - 2*Th3) - 500000000*Lx*TN*sin(Th1 - 2*Th2 + 2*Th4) - 500000000*Lx*TN*sin(Th1 + 2*Th2 - 2*Th4) - 500000000*Lx*TN*sin(Th1 - 2*Th3 + 2*Th4) - 2003501000*Ly*TN*cos(Th1) + 2003501000*Lx*TN*sin(Th1) - 500500000*Ly*TN*cos(Th1 - 2*Th2) - 500500000*Ly*TN*cos(Th1 - 2*Th3) + 1000500000*Ly*TN*cos(Th1 - 2*Th4) + 500000000*FX*sq(Lx)*cos(Th1 + 2*Th2 - 2*Th3) + 500000000*FX*sq(Lx)*cos(Th1 - 2*Th3 + 2*Th4) - 500000000*FX*sq(Ly)*cos(Th1 - 2*Th2 + 2*Th3) - 500000000*FX*sq(Ly)*cos(Th1 + 2*Th2 - 2*Th3) - 500500000*Lx*TN*sin(Th1 - 2*Th2) + 1000500000*Lx*TN*sin(Th1 - 2*Th3) - 500500000*Lx*TN*sin(Th1 - 2*Th4) - 500000000*FY*sq(Lx)*sin(Th1 - 2*Th2 + 2*Th4) - 500000000*FY*sq(Lx)*sin(Th1 + 2*Th2 - 2*Th4) + 500000000*FY*sq(Ly)*sin(Th1 + 2*Th2 - 2*Th4) + 500000000*FY*sq(Ly)*sin(Th1 + 2*Th3 - 2*Th4) - 1000500000*FX*Lx*Ly*sin(Th1) - 500500000*FY*Lx*Ly*cos(Th1 - 2*Th2) + 1001000000*FY*Lx*Ly*cos(Th1 + 2*Th2) - 500000000*FY*Lx*Ly*cos(Th1 - 2*Th3) - 1000500000*FY*Lx*Ly*cos(Th1 + 2*Th3) + 2001000000*FY*Lx*Ly*cos(Th1 - 2*Th4) - 1000500000*FY*Lx*Ly*cos(Th1 + 2*Th4) + 500500000*FX*Lx*Ly*sin(Th1 - 2*Th2) - 1001000000*FX*Lx*Ly*sin(Th1 + 2*Th2) - 2001000000*FX*Lx*Ly*sin(Th1 - 2*Th3) + 1000500000*FX*Lx*Ly*sin(Th1 + 2*Th3) + 500000000*FX*Lx*Ly*sin(Th1 - 2*Th4) + 1000500000*FX*Lx*Ly*sin(Th1 + 2*Th4) + 1000000000*FY*Lx*Ly*cos(2*Th3 - Th1 + 2*Th4) - 1000000000*FX*Lx*Ly*sin(2*Th3 - Th1 + 2*Th4) - 500000000*FY*Lx*Ly*cos(Th1 - 2*Th2 + 2*Th4) + 1000000000*FY*Lx*Ly*cos(Th1 + 2*Th2 - 2*Th4) - 500000000*FY*Lx*Ly*cos(Th1 - 2*Th3 + 2*Th4) - 500000000*FX*Lx*Ly*sin(Th1 - 2*Th2 + 2*Th3) + 1000000000*FX*Lx*Ly*sin(Th1 + 2*Th2 - 2*Th3) - 500000000*FX*Lx*Ly*sin(Th1 + 2*Th3 - 2*Th4) - 1000500000*FY*Lx*Ly*cos(Th1))/(k1*(1002000500*sq(Ly)*cos(2*Th1) - 500000*cos(2*Th1 - 2*Th3) - 500000*cos(2*Th1 - 2*Th4) - 500000*cos(2*Th2 - 2*Th3) - 500000*cos(2*Th2 - 2*Th4) - 500000*cos(2*Th3 - 2*Th4) - 1002000500*sq(Lx)*cos(2*Th1) - 1002000500*sq(Lx)*cos(2*Th2) - 1002000500*sq(Lx)*cos(2*Th3) - 1002000500*sq(Lx)*cos(2*Th4) - 500000*cos(2*Th1 - 2*Th2) + 1002000500*sq(Ly)*cos(2*Th2) + 1002000500*sq(Ly)*cos(2*Th3) + 1002000500*sq(Ly)*cos(2*Th4) + 500000*sq(Lx)*cos(2*Th1 - 2*Th2) - 2000500000*sq(Lx)*cos(2*Th1 - 2*Th3) + 500000*sq(Lx)*cos(2*Th1 - 2*Th4) + 500000*sq(Lx)*cos(2*Th2 - 2*Th3) - 2000500000*sq(Lx)*cos(2*Th2 - 2*Th4) + 500000*sq(Lx)*cos(2*Th3 - 2*Th4) + 500000*sq(Ly)*cos(2*Th1 - 2*Th2) + 500000*sq(Ly)*cos(2*Th1 - 2*Th3) - 2000500000*sq(Ly)*cos(2*Th1 - 2*Th4) - 2000500000*sq(Ly)*cos(2*Th2 - 2*Th3) + 500000*sq(Ly)*cos(2*Th2 - 2*Th4) + 500000*sq(Ly)*cos(2*Th3 - 2*Th4) + 4007002000*sq(Lx) + 4007002000*sq(Ly) + 500000000*sq(Lx)*cos(2*Th2 - 2*Th1 + 2*Th3) + 500000000*sq(Lx)*cos(2*Th1 + 2*Th2 - 2*Th3) + 500000000*sq(Lx)*cos(2*Th1 - 2*Th2 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th1 + 2*Th2 - 2*Th4) + 500000000*sq(Lx)*cos(2*Th3 - 2*Th1 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th1 - 2*Th3 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th3 - 2*Th2 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th2 + 2*Th3 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 - 2*Th2 + 2*Th3) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th2 - 2*Th3) - 500000000*sq(Ly)*cos(2*Th2 - 2*Th1 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th2 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th3 - 2*Th1 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th3 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th3 - 2*Th2 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th2 - 2*Th3 + 2*Th4) - 3004001000*Lx*Ly*sin(2*Th1) - 3004001000*Lx*Ly*sin(2*Th2) + 3004001000*Lx*Ly*sin(2*Th3) + 3004001000*Lx*Ly*sin(2*Th4) - 2001000000*Lx*Ly*sin(2*Th1 - 2*Th3) + 2001000000*Lx*Ly*sin(2*Th1 - 2*Th4) + 2001000000*Lx*Ly*sin(2*Th2 - 2*Th3) - 2001000000*Lx*Ly*sin(2*Th2 - 2*Th4) + 1000000000*Lx*Ly*sin(2*Th1 + 2*Th2 - 2*Th3) + 1000000000*Lx*Ly*sin(2*Th1 + 2*Th2 - 2*Th4) - 1000000000*Lx*Ly*sin(2*Th3 - 2*Th1 + 2*Th4) - 1000000000*Lx*Ly*sin(2*Th3 - 2*Th2 + 2*Th4) + 3004001));
% PWM2 = -(500000*FX*cos(Th2 - 2*Th3) - 1501000*FY*sin(Th2) - 1501000*FX*cos(Th2) + 500000*FX*cos(Th2 - 2*Th4) - 500000*FY*sin(Th2 - 2*Th3) - 500000*FY*sin(Th2 - 2*Th4) + 500000*FX*cos(2*Th1 - Th2) + 500000*FY*sin(2*Th1 - Th2) - 2001500000*FX*sq(Lx)*cos(Th2) - 2002000000*FX*sq(Ly)*cos(Th2) - 2002000000*FY*sq(Lx)*sin(Th2) - 2001500000*FY*sq(Ly)*sin(Th2) + 500500000*FX*sq(Lx)*cos(2*Th1 + Th2) + 500000000*FX*sq(Lx)*cos(Th2 - 2*Th3) + 500500000*FX*sq(Lx)*cos(Th2 + 2*Th3) + 2000500000*FX*sq(Lx)*cos(Th2 - 2*Th4) - 500500000*FX*sq(Ly)*cos(2*Th1 + Th2) + 1000000000*FX*sq(Ly)*cos(Th2 - 2*Th3) - 500000*FX*sq(Ly)*cos(Th2 - 2*Th4) - 500500000*FX*sq(Ly)*cos(Th2 + 2*Th4) - 500500000*Ly*TN*cos(2*Th1 - Th2) + 500500000*FY*sq(Lx)*sin(2*Th1 + Th2) + 500000*FY*sq(Lx)*sin(Th2 - 2*Th3) + 500500000*FY*sq(Lx)*sin(Th2 + 2*Th3) - 1000000000*FY*sq(Lx)*sin(Th2 - 2*Th4) - 500500000*FY*sq(Ly)*sin(2*Th1 + Th2) - 2000500000*FY*sq(Ly)*sin(Th2 - 2*Th3) - 500000000*FY*sq(Ly)*sin(Th2 - 2*Th4) - 500500000*FY*sq(Ly)*sin(Th2 + 2*Th4) - 500000000*FX*sq(Lx)*cos(2*Th1 - Th2 + 2*Th4) - 500000000*FX*sq(Lx)*cos(2*Th3 - Th2 + 2*Th4) + 500000000*FX*sq(Ly)*cos(2*Th1 - Th2 + 2*Th3) + 500000000*FX*sq(Ly)*cos(2*Th3 - Th2 + 2*Th4) + 500500000*Lx*TN*sin(2*Th1 - Th2) - 500000000*FY*sq(Lx)*sin(2*Th1 - Th2 + 2*Th4) - 500000000*FY*sq(Lx)*sin(2*Th3 - Th2 + 2*Th4) + 500000000*FY*sq(Ly)*sin(2*Th1 - Th2 + 2*Th3) + 500000000*FY*sq(Ly)*sin(2*Th3 - Th2 + 2*Th4) + 500000000*FX*sq(Lx)*cos(2*Th1 - Th2) - 500000*FX*sq(Ly)*cos(2*Th1 - Th2) + 500000000*Ly*TN*cos(2*Th1 + Th2 - 2*Th3) + 500000000*Ly*TN*cos(Th2 - 2*Th1 + 2*Th4) + 500000000*Ly*TN*cos(2*Th1 + Th2 - 2*Th4) + 500000000*Ly*TN*cos(Th2 - 2*Th3 + 2*Th4) - 500000*FY*sq(Lx)*sin(2*Th1 - Th2) + 500000000*FY*sq(Ly)*sin(2*Th1 - Th2) - 500000000*Lx*TN*sin(Th2 - 2*Th1 + 2*Th3) - 500000000*Lx*TN*sin(2*Th1 + Th2 - 2*Th3) - 500000000*Lx*TN*sin(2*Th1 + Th2 - 2*Th4) - 500000000*Lx*TN*sin(Th2 + 2*Th3 - 2*Th4) - 2003501000*Ly*TN*cos(Th2) + 2003501000*Lx*TN*sin(Th2) + 1000500000*Ly*TN*cos(Th2 - 2*Th3) - 500500000*Ly*TN*cos(Th2 - 2*Th4) - 500000000*FX*sq(Lx)*cos(2*Th1 + Th2 - 2*Th4) - 500000000*FX*sq(Lx)*cos(Th2 + 2*Th3 - 2*Th4) + 500000000*FX*sq(Ly)*cos(Th2 - 2*Th1 + 2*Th4) + 500000000*FX*sq(Ly)*cos(2*Th1 + Th2 - 2*Th4) - 500500000*Lx*TN*sin(Th2 - 2*Th3) + 1000500000*Lx*TN*sin(Th2 - 2*Th4) + 500000000*FY*sq(Lx)*sin(Th2 - 2*Th1 + 2*Th3) + 500000000*FY*sq(Lx)*sin(2*Th1 + Th2 - 2*Th3) - 500000000*FY*sq(Ly)*sin(2*Th1 + Th2 - 2*Th3) - 500000000*FY*sq(Ly)*sin(Th2 - 2*Th3 + 2*Th4) + 1000500000*FX*Lx*Ly*sin(Th2) - 1001000000*FY*Lx*Ly*cos(2*Th1 + Th2) - 2001000000*FY*Lx*Ly*cos(Th2 - 2*Th3) + 1000500000*FY*Lx*Ly*cos(Th2 + 2*Th3) + 500000000*FY*Lx*Ly*cos(Th2 - 2*Th4) + 1000500000*FY*Lx*Ly*cos(Th2 + 2*Th4) + 1001000000*FX*Lx*Ly*sin(2*Th1 + Th2) - 500000000*FX*Lx*Ly*sin(Th2 - 2*Th3) - 1000500000*FX*Lx*Ly*sin(Th2 + 2*Th3) + 2001000000*FX*Lx*Ly*sin(Th2 - 2*Th4) - 1000500000*FX*Lx*Ly*sin(Th2 + 2*Th4) - 1000000000*FY*Lx*Ly*cos(2*Th3 - Th2 + 2*Th4) + 1000000000*FX*Lx*Ly*sin(2*Th3 - Th2 + 2*Th4) + 500500000*FY*Lx*Ly*cos(2*Th1 - Th2) + 500500000*FX*Lx*Ly*sin(2*Th1 - Th2) + 500000000*FY*Lx*Ly*cos(Th2 - 2*Th1 + 2*Th3) - 1000000000*FY*Lx*Ly*cos(2*Th1 + Th2 - 2*Th3) + 500000000*FY*Lx*Ly*cos(Th2 + 2*Th3 - 2*Th4) + 500000000*FX*Lx*Ly*sin(Th2 - 2*Th1 + 2*Th4) - 1000000000*FX*Lx*Ly*sin(2*Th1 + Th2 - 2*Th4) + 500000000*FX*Lx*Ly*sin(Th2 - 2*Th3 + 2*Th4) + 1000500000*FY*Lx*Ly*cos(Th2))/(k1*(1002000500*sq(Ly)*cos(2*Th1) - 500000*cos(2*Th1 - 2*Th3) - 500000*cos(2*Th1 - 2*Th4) - 500000*cos(2*Th2 - 2*Th3) - 500000*cos(2*Th2 - 2*Th4) - 500000*cos(2*Th3 - 2*Th4) - 1002000500*sq(Lx)*cos(2*Th1) - 1002000500*sq(Lx)*cos(2*Th2) - 1002000500*sq(Lx)*cos(2*Th3) - 1002000500*sq(Lx)*cos(2*Th4) - 500000*cos(2*Th1 - 2*Th2) + 1002000500*sq(Ly)*cos(2*Th2) + 1002000500*sq(Ly)*cos(2*Th3) + 1002000500*sq(Ly)*cos(2*Th4) + 500000*sq(Lx)*cos(2*Th1 - 2*Th2) - 2000500000*sq(Lx)*cos(2*Th1 - 2*Th3) + 500000*sq(Lx)*cos(2*Th1 - 2*Th4) + 500000*sq(Lx)*cos(2*Th2 - 2*Th3) - 2000500000*sq(Lx)*cos(2*Th2 - 2*Th4) + 500000*sq(Lx)*cos(2*Th3 - 2*Th4) + 500000*sq(Ly)*cos(2*Th1 - 2*Th2) + 500000*sq(Ly)*cos(2*Th1 - 2*Th3) - 2000500000*sq(Ly)*cos(2*Th1 - 2*Th4) - 2000500000*sq(Ly)*cos(2*Th2 - 2*Th3) + 500000*sq(Ly)*cos(2*Th2 - 2*Th4) + 500000*sq(Ly)*cos(2*Th3 - 2*Th4) + 4007002000*sq(Lx) + 4007002000*sq(Ly) + 500000000*sq(Lx)*cos(2*Th2 - 2*Th1 + 2*Th3) + 500000000*sq(Lx)*cos(2*Th1 + 2*Th2 - 2*Th3) + 500000000*sq(Lx)*cos(2*Th1 - 2*Th2 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th1 + 2*Th2 - 2*Th4) + 500000000*sq(Lx)*cos(2*Th3 - 2*Th1 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th1 - 2*Th3 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th3 - 2*Th2 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th2 + 2*Th3 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 - 2*Th2 + 2*Th3) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th2 - 2*Th3) - 500000000*sq(Ly)*cos(2*Th2 - 2*Th1 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th2 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th3 - 2*Th1 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th3 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th3 - 2*Th2 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th2 - 2*Th3 + 2*Th4) - 3004001000*Lx*Ly*sin(2*Th1) - 3004001000*Lx*Ly*sin(2*Th2) + 3004001000*Lx*Ly*sin(2*Th3) + 3004001000*Lx*Ly*sin(2*Th4) - 2001000000*Lx*Ly*sin(2*Th1 - 2*Th3) + 2001000000*Lx*Ly*sin(2*Th1 - 2*Th4) + 2001000000*Lx*Ly*sin(2*Th2 - 2*Th3) - 2001000000*Lx*Ly*sin(2*Th2 - 2*Th4) + 1000000000*Lx*Ly*sin(2*Th1 + 2*Th2 - 2*Th3) + 1000000000*Lx*Ly*sin(2*Th1 + 2*Th2 - 2*Th4) - 1000000000*Lx*Ly*sin(2*Th3 - 2*Th1 + 2*Th4) - 1000000000*Lx*Ly*sin(2*Th3 - 2*Th2 + 2*Th4) + 3004001));
% PWM3 = -(500000*FX*cos(Th3 - 2*Th4) - 1501000*FY*sin(Th3) - 1501000*FX*cos(Th3) - 500000*FY*sin(Th3 - 2*Th4) + 500000*FX*cos(2*Th1 - Th3) + 500000*FX*cos(2*Th2 - Th3) + 500000*FY*sin(2*Th1 - Th3) + 500000*FY*sin(2*Th2 - Th3) - 2001500000*FX*sq(Lx)*cos(Th3) - 2002000000*FX*sq(Ly)*cos(Th3) - 2002000000*FY*sq(Lx)*sin(Th3) - 2001500000*FY*sq(Ly)*sin(Th3) + 500500000*FX*sq(Lx)*cos(2*Th2 + Th3) + 500000000*FX*sq(Lx)*cos(Th3 - 2*Th4) + 500500000*FX*sq(Lx)*cos(Th3 + 2*Th4) - 500500000*FX*sq(Ly)*cos(2*Th1 + Th3) - 500000*FX*sq(Ly)*cos(Th3 - 2*Th4) - 500500000*FX*sq(Ly)*cos(Th3 + 2*Th4) - 500500000*Ly*TN*cos(2*Th1 - Th3) + 1000500000*Ly*TN*cos(2*Th2 - Th3) + 500500000*FY*sq(Lx)*sin(2*Th2 + Th3) + 500000*FY*sq(Lx)*sin(Th3 - 2*Th4) + 500500000*FY*sq(Lx)*sin(Th3 + 2*Th4) - 500500000*FY*sq(Ly)*sin(2*Th1 + Th3) - 500000000*FY*sq(Ly)*sin(Th3 - 2*Th4) - 500500000*FY*sq(Ly)*sin(Th3 + 2*Th4) - 500000000*FX*sq(Lx)*cos(2*Th1 + 2*Th2 - Th3) - 500000000*FX*sq(Lx)*cos(2*Th1 - Th3 + 2*Th4) + 500000000*FX*sq(Ly)*cos(2*Th1 + 2*Th2 - Th3) + 500000000*FX*sq(Ly)*cos(2*Th2 - Th3 + 2*Th4) + 1000500000*Lx*TN*sin(2*Th1 - Th3) - 500500000*Lx*TN*sin(2*Th2 - Th3) - 500000000*FY*sq(Lx)*sin(2*Th1 + 2*Th2 - Th3) - 500000000*FY*sq(Lx)*sin(2*Th1 - Th3 + 2*Th4) + 500000000*FY*sq(Ly)*sin(2*Th1 + 2*Th2 - Th3) + 500000000*FY*sq(Ly)*sin(2*Th2 - Th3 + 2*Th4) + 2000500000*FX*sq(Lx)*cos(2*Th1 - Th3) + 500000000*FX*sq(Lx)*cos(2*Th2 - Th3) - 500000*FX*sq(Ly)*cos(2*Th1 - Th3) + 1000000000*FX*sq(Ly)*cos(2*Th2 - Th3) + 500000000*Ly*TN*cos(2*Th1 - 2*Th2 + Th3) + 500000000*Ly*TN*cos(Th3 - 2*Th1 + 2*Th4) + 500000000*Ly*TN*cos(2*Th1 + Th3 - 2*Th4) + 500000000*Ly*TN*cos(Th3 - 2*Th2 + 2*Th4) + 1000000000*FY*sq(Lx)*sin(2*Th1 - Th3) - 500000*FY*sq(Lx)*sin(2*Th2 - Th3) + 500000000*FY*sq(Ly)*sin(2*Th1 - Th3) + 2000500000*FY*sq(Ly)*sin(2*Th2 - Th3) + 500000000*Lx*TN*sin(2*Th2 - 2*Th1 + Th3) + 500000000*Lx*TN*sin(Th3 - 2*Th1 + 2*Th4) + 500000000*Lx*TN*sin(Th3 - 2*Th2 + 2*Th4) + 500000000*Lx*TN*sin(2*Th2 + Th3 - 2*Th4) - 2003501000*Ly*TN*cos(Th3) - 2003501000*Lx*TN*sin(Th3) - 500500000*Ly*TN*cos(Th3 - 2*Th4) - 500000000*FX*sq(Lx)*cos(2*Th2 - 2*Th1 + Th3) - 500000000*FX*sq(Lx)*cos(Th3 - 2*Th1 + 2*Th4) + 500000000*FX*sq(Ly)*cos(Th3 - 2*Th1 + 2*Th4) + 500000000*FX*sq(Ly)*cos(2*Th1 + Th3 - 2*Th4) + 500500000*Lx*TN*sin(Th3 - 2*Th4) + 500000000*FY*sq(Lx)*sin(Th3 - 2*Th2 + 2*Th4) + 500000000*FY*sq(Lx)*sin(2*Th2 + Th3 - 2*Th4) - 500000000*FY*sq(Ly)*sin(2*Th1 - 2*Th2 + Th3) - 500000000*FY*sq(Ly)*sin(Th3 - 2*Th2 + 2*Th4) - 1000500000*FX*Lx*Ly*sin(Th3) - 1000500000*FY*Lx*Ly*cos(2*Th1 + Th3) - 1000500000*FY*Lx*Ly*cos(2*Th2 + Th3) - 500500000*FY*Lx*Ly*cos(Th3 - 2*Th4) + 1001000000*FY*Lx*Ly*cos(Th3 + 2*Th4) + 1000500000*FX*Lx*Ly*sin(2*Th1 + Th3) + 1000500000*FX*Lx*Ly*sin(2*Th2 + Th3) + 500500000*FX*Lx*Ly*sin(Th3 - 2*Th4) - 1001000000*FX*Lx*Ly*sin(Th3 + 2*Th4) + 1000000000*FY*Lx*Ly*cos(2*Th1 + 2*Th2 - Th3) - 1000000000*FX*Lx*Ly*sin(2*Th1 + 2*Th2 - Th3) - 500000000*FY*Lx*Ly*cos(2*Th1 - Th3) + 2001000000*FY*Lx*Ly*cos(2*Th2 - Th3) + 2001000000*FX*Lx*Ly*sin(2*Th1 - Th3) - 500000000*FX*Lx*Ly*sin(2*Th2 - Th3) - 500000000*FY*Lx*Ly*cos(2*Th2 - 2*Th1 + Th3) + 1000000000*FY*Lx*Ly*cos(Th3 - 2*Th2 + 2*Th4) - 500000000*FY*Lx*Ly*cos(2*Th2 + Th3 - 2*Th4) - 500000000*FX*Lx*Ly*sin(2*Th1 - 2*Th2 + Th3) + 1000000000*FX*Lx*Ly*sin(Th3 - 2*Th1 + 2*Th4) - 500000000*FX*Lx*Ly*sin(2*Th1 + Th3 - 2*Th4) - 1000500000*FY*Lx*Ly*cos(Th3))/(k1*(1002000500*sq(Ly)*cos(2*Th1) - 500000*cos(2*Th1 - 2*Th3) - 500000*cos(2*Th1 - 2*Th4) - 500000*cos(2*Th2 - 2*Th3) - 500000*cos(2*Th2 - 2*Th4) - 500000*cos(2*Th3 - 2*Th4) - 1002000500*sq(Lx)*cos(2*Th1) - 1002000500*sq(Lx)*cos(2*Th2) - 1002000500*sq(Lx)*cos(2*Th3) - 1002000500*sq(Lx)*cos(2*Th4) - 500000*cos(2*Th1 - 2*Th2) + 1002000500*sq(Ly)*cos(2*Th2) + 1002000500*sq(Ly)*cos(2*Th3) + 1002000500*sq(Ly)*cos(2*Th4) + 500000*sq(Lx)*cos(2*Th1 - 2*Th2) - 2000500000*sq(Lx)*cos(2*Th1 - 2*Th3) + 500000*sq(Lx)*cos(2*Th1 - 2*Th4) + 500000*sq(Lx)*cos(2*Th2 - 2*Th3) - 2000500000*sq(Lx)*cos(2*Th2 - 2*Th4) + 500000*sq(Lx)*cos(2*Th3 - 2*Th4) + 500000*sq(Ly)*cos(2*Th1 - 2*Th2) + 500000*sq(Ly)*cos(2*Th1 - 2*Th3) - 2000500000*sq(Ly)*cos(2*Th1 - 2*Th4) - 2000500000*sq(Ly)*cos(2*Th2 - 2*Th3) + 500000*sq(Ly)*cos(2*Th2 - 2*Th4) + 500000*sq(Ly)*cos(2*Th3 - 2*Th4) + 4007002000*sq(Lx) + 4007002000*sq(Ly) + 500000000*sq(Lx)*cos(2*Th2 - 2*Th1 + 2*Th3) + 500000000*sq(Lx)*cos(2*Th1 + 2*Th2 - 2*Th3) + 500000000*sq(Lx)*cos(2*Th1 - 2*Th2 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th1 + 2*Th2 - 2*Th4) + 500000000*sq(Lx)*cos(2*Th3 - 2*Th1 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th1 - 2*Th3 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th3 - 2*Th2 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th2 + 2*Th3 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 - 2*Th2 + 2*Th3) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th2 - 2*Th3) - 500000000*sq(Ly)*cos(2*Th2 - 2*Th1 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th2 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th3 - 2*Th1 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th3 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th3 - 2*Th2 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th2 - 2*Th3 + 2*Th4) - 3004001000*Lx*Ly*sin(2*Th1) - 3004001000*Lx*Ly*sin(2*Th2) + 3004001000*Lx*Ly*sin(2*Th3) + 3004001000*Lx*Ly*sin(2*Th4) - 2001000000*Lx*Ly*sin(2*Th1 - 2*Th3) + 2001000000*Lx*Ly*sin(2*Th1 - 2*Th4) + 2001000000*Lx*Ly*sin(2*Th2 - 2*Th3) - 2001000000*Lx*Ly*sin(2*Th2 - 2*Th4) + 1000000000*Lx*Ly*sin(2*Th1 + 2*Th2 - 2*Th3) + 1000000000*Lx*Ly*sin(2*Th1 + 2*Th2 - 2*Th4) - 1000000000*Lx*Ly*sin(2*Th3 - 2*Th1 + 2*Th4) - 1000000000*Lx*Ly*sin(2*Th3 - 2*Th2 + 2*Th4) + 3004001));
% PWM4 = (1501000*FX*cos(Th4) + 1501000*FY*sin(Th4) - 500000*FX*cos(2*Th1 - Th4) - 500000*FX*cos(2*Th2 - Th4) - 500000*FX*cos(2*Th3 - Th4) - 500000*FY*sin(2*Th1 - Th4) - 500000*FY*sin(2*Th2 - Th4) - 500000*FY*sin(2*Th3 - Th4) + 2001500000*FX*sq(Lx)*cos(Th4) + 2002000000*FX*sq(Ly)*cos(Th4) + 2002000000*FY*sq(Lx)*sin(Th4) + 2001500000*FY*sq(Ly)*sin(Th4) - 500500000*FX*sq(Lx)*cos(2*Th1 + Th4) - 500500000*FX*sq(Lx)*cos(2*Th3 + Th4) + 500500000*FX*sq(Ly)*cos(2*Th2 + Th4) + 500500000*FX*sq(Ly)*cos(2*Th3 + Th4) + 1000500000*Ly*TN*cos(2*Th1 - Th4) - 500500000*Ly*TN*cos(2*Th2 - Th4) - 500500000*Ly*TN*cos(2*Th3 - Th4) - 500500000*FY*sq(Lx)*sin(2*Th1 + Th4) - 500500000*FY*sq(Lx)*sin(2*Th3 + Th4) + 500500000*FY*sq(Ly)*sin(2*Th2 + Th4) + 500500000*FY*sq(Ly)*sin(2*Th3 + Th4) + 500000000*FX*sq(Lx)*cos(2*Th1 + 2*Th2 - Th4) + 500000000*FX*sq(Lx)*cos(2*Th2 + 2*Th3 - Th4) - 500000000*FX*sq(Ly)*cos(2*Th1 + 2*Th2 - Th4) - 500000000*FX*sq(Ly)*cos(2*Th1 + 2*Th3 - Th4) - 500500000*Lx*TN*sin(2*Th1 - Th4) + 1000500000*Lx*TN*sin(2*Th2 - Th4) - 500500000*Lx*TN*sin(2*Th3 - Th4) + 500000000*FY*sq(Lx)*sin(2*Th1 + 2*Th2 - Th4) + 500000000*FY*sq(Lx)*sin(2*Th2 + 2*Th3 - Th4) - 500000000*FY*sq(Ly)*sin(2*Th1 + 2*Th2 - Th4) - 500000000*FY*sq(Ly)*sin(2*Th1 + 2*Th3 - Th4) - 500000000*FX*sq(Lx)*cos(2*Th1 - Th4) - 2000500000*FX*sq(Lx)*cos(2*Th2 - Th4) - 500000000*FX*sq(Lx)*cos(2*Th3 - Th4) - 1000000000*FX*sq(Ly)*cos(2*Th1 - Th4) + 500000*FX*sq(Ly)*cos(2*Th2 - Th4) + 500000*FX*sq(Ly)*cos(2*Th3 - Th4) + 500000000*Ly*TN*cos(2*Th2 - 2*Th1 + Th4) + 500000000*Ly*TN*cos(2*Th3 - 2*Th1 + Th4) + 500000000*Ly*TN*cos(2*Th3 - 2*Th2 + Th4) + 500000000*Ly*TN*cos(2*Th2 - 2*Th3 + Th4) + 500000*FY*sq(Lx)*sin(2*Th1 - Th4) - 1000000000*FY*sq(Lx)*sin(2*Th2 - Th4) + 500000*FY*sq(Lx)*sin(2*Th3 - Th4) - 2000500000*FY*sq(Ly)*sin(2*Th1 - Th4) - 500000000*FY*sq(Ly)*sin(2*Th2 - Th4) - 500000000*FY*sq(Ly)*sin(2*Th3 - Th4) + 500000000*Lx*TN*sin(2*Th1 - 2*Th2 + Th4) + 500000000*Lx*TN*sin(2*Th3 - 2*Th1 + Th4) + 500000000*Lx*TN*sin(2*Th1 - 2*Th3 + Th4) + 500000000*Lx*TN*sin(2*Th3 - 2*Th2 + Th4) - 2003501000*Ly*TN*cos(Th4) - 2003501000*Lx*TN*sin(Th4) + 500000000*FX*sq(Lx)*cos(2*Th1 - 2*Th2 + Th4) + 500000000*FX*sq(Lx)*cos(2*Th3 - 2*Th2 + Th4) - 500000000*FX*sq(Ly)*cos(2*Th3 - 2*Th2 + Th4) - 500000000*FX*sq(Ly)*cos(2*Th2 - 2*Th3 + Th4) - 500000000*FY*sq(Lx)*sin(2*Th3 - 2*Th1 + Th4) - 500000000*FY*sq(Lx)*sin(2*Th1 - 2*Th3 + Th4) + 500000000*FY*sq(Ly)*sin(2*Th2 - 2*Th1 + Th4) + 500000000*FY*sq(Ly)*sin(2*Th3 - 2*Th1 + Th4) + 1000500000*FX*Lx*Ly*sin(Th4) + 1000500000*FY*Lx*Ly*cos(2*Th1 + Th4) + 1000500000*FY*Lx*Ly*cos(2*Th2 + Th4) - 1001000000*FY*Lx*Ly*cos(2*Th3 + Th4) - 1000500000*FX*Lx*Ly*sin(2*Th1 + Th4) - 1000500000*FX*Lx*Ly*sin(2*Th2 + Th4) + 1001000000*FX*Lx*Ly*sin(2*Th3 + Th4) - 1000000000*FY*Lx*Ly*cos(2*Th1 + 2*Th2 - Th4) + 1000000000*FX*Lx*Ly*sin(2*Th1 + 2*Th2 - Th4) - 2001000000*FY*Lx*Ly*cos(2*Th1 - Th4) + 500000000*FY*Lx*Ly*cos(2*Th2 - Th4) + 500500000*FY*Lx*Ly*cos(2*Th3 - Th4) + 500000000*FX*Lx*Ly*sin(2*Th1 - Th4) - 2001000000*FX*Lx*Ly*sin(2*Th2 - Th4) + 500500000*FX*Lx*Ly*sin(2*Th3 - Th4) + 500000000*FY*Lx*Ly*cos(2*Th1 - 2*Th2 + Th4) - 1000000000*FY*Lx*Ly*cos(2*Th3 - 2*Th1 + Th4) + 500000000*FY*Lx*Ly*cos(2*Th1 - 2*Th3 + Th4) + 500000000*FX*Lx*Ly*sin(2*Th2 - 2*Th1 + Th4) - 1000000000*FX*Lx*Ly*sin(2*Th3 - 2*Th2 + Th4) + 500000000*FX*Lx*Ly*sin(2*Th2 - 2*Th3 + Th4) + 1000500000*FY*Lx*Ly*cos(Th4))/(k1*(1002000500*sq(Ly)*cos(2*Th1) - 500000*cos(2*Th1 - 2*Th3) - 500000*cos(2*Th1 - 2*Th4) - 500000*cos(2*Th2 - 2*Th3) - 500000*cos(2*Th2 - 2*Th4) - 500000*cos(2*Th3 - 2*Th4) - 1002000500*sq(Lx)*cos(2*Th1) - 1002000500*sq(Lx)*cos(2*Th2) - 1002000500*sq(Lx)*cos(2*Th3) - 1002000500*sq(Lx)*cos(2*Th4) - 500000*cos(2*Th1 - 2*Th2) + 1002000500*sq(Ly)*cos(2*Th2) + 1002000500*sq(Ly)*cos(2*Th3) + 1002000500*sq(Ly)*cos(2*Th4) + 500000*sq(Lx)*cos(2*Th1 - 2*Th2) - 2000500000*sq(Lx)*cos(2*Th1 - 2*Th3) + 500000*sq(Lx)*cos(2*Th1 - 2*Th4) + 500000*sq(Lx)*cos(2*Th2 - 2*Th3) - 2000500000*sq(Lx)*cos(2*Th2 - 2*Th4) + 500000*sq(Lx)*cos(2*Th3 - 2*Th4) + 500000*sq(Ly)*cos(2*Th1 - 2*Th2) + 500000*sq(Ly)*cos(2*Th1 - 2*Th3) - 2000500000*sq(Ly)*cos(2*Th1 - 2*Th4) - 2000500000*sq(Ly)*cos(2*Th2 - 2*Th3) + 500000*sq(Ly)*cos(2*Th2 - 2*Th4) + 500000*sq(Ly)*cos(2*Th3 - 2*Th4) + 4007002000*sq(Lx) + 4007002000*sq(Ly) + 500000000*sq(Lx)*cos(2*Th2 - 2*Th1 + 2*Th3) + 500000000*sq(Lx)*cos(2*Th1 + 2*Th2 - 2*Th3) + 500000000*sq(Lx)*cos(2*Th1 - 2*Th2 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th1 + 2*Th2 - 2*Th4) + 500000000*sq(Lx)*cos(2*Th3 - 2*Th1 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th1 - 2*Th3 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th3 - 2*Th2 + 2*Th4) + 500000000*sq(Lx)*cos(2*Th2 + 2*Th3 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 - 2*Th2 + 2*Th3) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th2 - 2*Th3) - 500000000*sq(Ly)*cos(2*Th2 - 2*Th1 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th2 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th3 - 2*Th1 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th1 + 2*Th3 - 2*Th4) - 500000000*sq(Ly)*cos(2*Th3 - 2*Th2 + 2*Th4) - 500000000*sq(Ly)*cos(2*Th2 - 2*Th3 + 2*Th4) - 3004001000*Lx*Ly*sin(2*Th1) - 3004001000*Lx*Ly*sin(2*Th2) + 3004001000*Lx*Ly*sin(2*Th3) + 3004001000*Lx*Ly*sin(2*Th4) - 2001000000*Lx*Ly*sin(2*Th1 - 2*Th3) + 2001000000*Lx*Ly*sin(2*Th1 - 2*Th4) + 2001000000*Lx*Ly*sin(2*Th2 - 2*Th3) - 2001000000*Lx*Ly*sin(2*Th2 - 2*Th4) + 1000000000*Lx*Ly*sin(2*Th1 + 2*Th2 - 2*Th3) + 1000000000*Lx*Ly*sin(2*Th1 + 2*Th2 - 2*Th4) - 1000000000*Lx*Ly*sin(2*Th3 - 2*Th1 + 2*Th4) - 1000000000*Lx*Ly*sin(2*Th3 - 2*Th2 + 2*Th4) + 3004001));
PWM1 = ((FX/(4*k1) - (Ly*TN)/(4*k1*(Lx^2 + Ly^2)))^2 + (FY/(4*k1) + (Lx*TN)/(4*k1*(Lx^2 + Ly^2)))^2)^(1/2);
PWM2 = ((FX/(4*k2) + (Ly*TN)/(4*k2*(Lx^2 + Ly^2)))^2 + (FY/(4*k2) - (Lx*TN)/(4*k2*(Lx^2 + Ly^2)))^2)^(1/2);
PWM3 = ((FX/(4*k3) + (Ly*TN)/(4*k3*(Lx^2 + Ly^2)))^2 + (FY/(4*k3) + (Lx*TN)/(4*k3*(Lx^2 + Ly^2)))^2)^(1/2);
PWM4 = ((FX/(4*k4) - (Ly*TN)/(4*k4*(Lx^2 + Ly^2)))^2 + (FY/(4*k4) - (Lx*TN)/(4*k4*(Lx^2 + Ly^2)))^2)^(1/2);
Th1 = atan2(FY/(4*k1) + (Lx*TN)/(4*k1*(Lx^2 + Ly^2)), FX/(4*k1) - (Ly*TN)/(4*k1*(Lx^2 + Ly^2)));
Th2 = atan2(FY/(4*k2) - (Lx*TN)/(4*k2*(Lx^2 + Ly^2)), FX/(4*k2) + (Ly*TN)/(4*k2*(Lx^2 + Ly^2)));
Th3 = atan2(FY/(4*k3) + (Lx*TN)/(4*k3*(Lx^2 + Ly^2)), FX/(4*k3) + (Ly*TN)/(4*k3*(Lx^2 + Ly^2)));
Th4 = atan2(FY/(4*k4) - (Lx*TN)/(4*k4*(Lx^2 + Ly^2)), FX/(4*k4) - (Ly*TN)/(4*k4*(Lx^2 + Ly^2)));

    %                   Saturação
    PWM1 = constrain_float(PWM1,Pwmmin,Pwmmax);
    PWM2 = constrain_float(PWM2,Pwmmin,Pwmmax);
    PWM3 = constrain_float(PWM3,Pwmmin,Pwmmax);
    PWM4 = constrain_float(PWM4,Pwmmin,Pwmmax);

    %          Saturação
    Th1 = constrain_float(Th1,-M_PI,M_PI);
    Th2 = constrain_float(Th2,-M_PI,M_PI);
    Th3 = constrain_float(Th3,-M_PI,M_PI);
    Th4 = constrain_float(Th4,-M_PI,M_PI);
    
    PWM   = [PWM1;PWM2;PWM3;PWM4];
    Theta = [Th1;Th2;Th3;Th4];
    
    % =============================================================================================================================
    F = DirAllocationMatrix(PWM,Theta);
    Err = norm([FX;FY;TN]-F);% colocar um erro pra cada F
    Erro = [FX;FY;TN]-F;
  
    
end

end