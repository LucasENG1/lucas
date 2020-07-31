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
while(Err>1 && aux < 1)
    aux = aux +1;
    %========================================== PWM calculado a partir da força e dos angulos ===================================
    
    PWM1 = (sqrt(sq(FX/(4*k1) - (Ly*TN)/(4*k1*(sq(Lx) + sq(Ly)))) + sq(FY/(4*k1) + (Lx*TN)/(4*k1*(sq(Lx) + sq(Ly))))));
    PWM2 = (sqrt(sq(FX/(4*k2) + (Ly*TN)/(4*k2*(sq(Lx) + sq(Ly)))) + sq(FY/(4*k2) - (Lx*TN)/(4*k2*(sq(Lx) + sq(Ly))))));
    PWM3 = (sqrt(sq(FX/(4*k3) + (Ly*TN)/(4*k3*(sq(Lx) + sq(Ly)))) + sq(FY/(4*k3) + (Lx*TN)/(4*k3*(sq(Lx) + sq(Ly))))));
    PWM4 = (sqrt(sq(FX/(4*k4) - (Ly*TN)/(4*k4*(sq(Lx) + sq(Ly)))) + sq(FY/(4*k4) - (Lx*TN)/(4*k4*(sq(Lx) + sq(Ly))))));
    
    %                   Saturação
    PWM1 = constrain_float(PWM1,Pwmmin,Pwmmax);
    PWM2 = constrain_float(PWM2,Pwmmin,Pwmmax);
    PWM3 = constrain_float(PWM3,Pwmmin,Pwmmax);
    PWM4 = constrain_float(PWM4,Pwmmin,Pwmmax);
    
    %=============================== Arco seno do angulo calculado a partir da força e do novo PWM ===============================
    Th1 = atan2(FY/(4*PWM1*k1) + (Lx*TN)/(4*PWM1*k1*(Lx^2 + Ly^2)), FX/(4*PWM1*k1) - (Ly*TN)/(4*PWM1*k1*(Lx^2 + Ly^2)));
    Th2 = atan2(FY/(4*PWM2*k2) - (Lx*TN)/(4*PWM2*k2*(Lx^2 + Ly^2)), FX/(4*PWM2*k2) + (Ly*TN)/(4*PWM2*k2*(Lx^2 + Ly^2)));
    Th3 = atan2(FY/(4*PWM3*k3) + (Lx*TN)/(4*PWM3*k3*(Lx^2 + Ly^2)), FX/(4*PWM3*k3) + (Ly*TN)/(4*PWM3*k3*(Lx^2 + Ly^2)));
    Th4 = atan2(FY/(4*PWM4*k4) - (Lx*TN)/(4*PWM4*k4*(Lx^2 + Ly^2)), FX/(4*PWM4*k4) - (Ly*TN)/(4*PWM4*k4*(Lx^2 + Ly^2)));
    
    %          Saturação
    Th1 = constrain_float(Th1,-M_PI,M_PI);
    Th2 = constrain_float(Th2,-M_PI,M_PI);
    Th3 = constrain_float(Th3,-M_PI,M_PI);
    Th4 = constrain_float(Th4,-M_PI,M_PI);
    
    % =============================================================================================================================
    F = DirAllocationMatrix(PWM,Theta);
    Err = norm([FX;FY;TN]-F);% colocar um erro pra cada F
    Erro = [FX;FY;TN]-F;
    
    
end

PWM   = [PWM1;PWM2;PWM3;PWM4];
Theta = [Th1;Th2;Th3;Th4];

end
