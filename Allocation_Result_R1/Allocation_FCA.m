function [Th,PWM,Erro,F_out] = Allocation_FCA(F,Th,PWM,i)
global k1 Lx Ly Pwmmax Pwmmin;

iteracao   = 50;
tolerancia = 0.01*norm(F(:,i-1));
Err       = 100;
j = 0;

% FX = real(F(1));
% FY = real(F(2));
% TN = real(F(3));

%% Dependendo da ordem de alocaÁ„o, um dos conjuntos abaixo nao È usado
% PWM = NormtoPWM(Pwm);%       // Converte o valor normalizado de 0  a 1 para PWM
% Th  = Theta.* DEG_TO_RAD;%     // Convertendo de grau para Radianos

Th1 = Th(1,i-1);
Th2 = Th(2,i-1);
Th3 = Th(3,i-1);
Th4 = Th(4,i-1);

PWM1 = PWM(1,i-1);
PWM2 = PWM(2,i-1);
PWM3 = PWM(3,i-1);
PWM4 = PWM(4,i-1);

if norm(F(:,i-1))> 1e-5
    while((j<=iteracao) && (Err>tolerancia))
        j = j + 1;
        %% ========================================== PWM calculado a partir da for√ßa e dos angulos ===================================
        M2 =[cos(Th1)                        cos(Th2)                       cos(Th3)                       cos(Th4);
            sin(Th1)                         sin(Th2)                       sin(Th3)                       sin(Th4);
            (-Ly*cos(Th1)+Lx*sin(Th1))  (Ly*cos(Th2)-Lx*sin(Th2)) (Ly*cos(Th3)+Lx*sin(Th3)) (-Ly*cos(Th4)-Lx*sin(Th4))];
        
        K1 = diag([k1 k1 k1 k1]);
        
        M2_Inv = pinv(M2);%inv(W)*transpose(M2)/((M2*inv(W)*transpose(M2))+ep); % Eq. 12.276
        
        Pwm = inv(K1)* M2_Inv * F(:,i-1);
        
        PWM1 = Pwm(1);
        PWM2 = Pwm(2);
        PWM3 = Pwm(3);
        PWM4 = Pwm(4);
        
        %         [T,PM] = DynamicsOfServosAndMotors(i,[Th,[Th1;Th2;Th3;Th4]],[PWM,Pwm]);
        
        
        
        %% Calculo do Theta
        M1 =  [PWM1      0         PWM2      0         PWM3     0         PWM4       0   ;
            0         PWM1      0         PWM2      0        PWM3      0          PWM4;
            -Ly*PWM1   Lx*PWM1   Ly*PWM2  -Lx*PWM2   Ly*PWM3  Lx*PWM3  -Ly*PWM4   -Lx*PWM4];
        
        K = diag([k1 k1 k1 k1 k1 k1 k1 k1]);
        
        M1_Inv = pinv(M1);  %transpose(M1)/(M1*transpose(M1));%+1e-5*eye(size(M1*transpose(M1))));
        
        F1 = inv(K)*M1_Inv * F(:,i-1);
        
        Th1 = atan2(F1(2),F1(1));
        Th2 = atan2(F1(4),F1(3));
        Th3 = atan2(F1(6),F1(5));
        Th4 = atan2(F1(8),F1(7));
        
        %         [T,P] = DynamicsOfServosAndMotors(i,[Th,[Th1;Th2;Th3;Th4]],[PWM,[PWM1;PWM2;PWM3;PWM4]]);
        %         Th1 = T(1);
        %         Th2 = T(2);
        %         Th3 = T(3);
        %         Th4 = T(4);
        
        %% Satura
        Th1 = Satura(Th1,pi,-pi);
        Th2 = Satura(Th2,pi,-pi);
        Th3 = Satura(Th3,pi,-pi);
        Th4 = Satura(Th4,pi,-pi);
        
        PWM1 = Satura(PWM(1),Pwmmax,Pwmmin);
        PWM2 = Satura(PWM(2),Pwmmax,Pwmmin);
        PWM3 = Satura(PWM(3),Pwmmax,Pwmmin);
        PWM4 = Satura(PWM(4),Pwmmax,Pwmmin);
        
        %%
        F_out = Aloc_Direta([Th1;Th2;Th3;Th4],[PWM1;PWM2;PWM3;PWM4]);
        
        Erro = (F(:,i-1) - F_out);
        Err  = norm(Erro);
    end
else
    
    F_out = zeros(3,1);
    PWM   =1e-10*ones(4,1);
    Theta = zeros(4,1);
    Erro = 0;
end
j
%%
PWM = [PWM1;PWM2;PWM3;PWM4];
% PWM = PWMtoNorm(PWM);
Th  = [Th1;Th2;Th3;Th4];
% Th = Th .* RAD_TO_DEG;

end