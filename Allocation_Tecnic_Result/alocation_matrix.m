function [Th,PWM] = alocation_matrix(F,th,pwm,k)
global Fmax Nmax DEG_TO_RAD RAD_TO_DEG k1 k2 k3 k4 M_PI Lx Ly Pwmmax Pwmmin;

FX = F(1) * Fmax;
FY = F(2) * Fmax;
TN = F(3) * Nmax;
%% Dependendo da ordem de alocação, um dos conjuntos abaixo nao é usado
PWM = NormtoPWM(pwm(:,k));%       // Converte o valor normalizado de 0  a 1 para PWM
Th  = th(:,k) .* DEG_TO_RAD;%     // Convertendo de grau para Radianos
%% Pesos
w1 = 1; w3 = 1;
w2 = 1; w4 = 1;

K  = diag([k1 k2 k3 k4]);
W  = diag([w1 w2 w3 w4]);
K1 = diag([k1 k1 k2 k2 k3 k3 k4 k4]);
W1 = diag([w1 w1 w2 w2 w3 w3 w4 w4]);
Er = 1000;
i = 0;
while Er >1e-3 && i<100
    %% Calculo do Angulo
    M2 = [PWM(1)      0           PWM(2)      0          PWM(3)       0            PWM(4)       0  ;
        0           PWM(1)      0           PWM(2)     0            PWM(3)       0          PWM(4) ;
      -Ly*PWM(1)    Lx*PWM(1)   Ly*PWM(2)  -Lx*PWM(2)  Ly*PWM(3)    Lx*PWM(3)  -Ly*PWM(4)  -Lx*PWM(4)];
    
    ep = 1e-5*eye(size(M2*transpose(M2))); % tratamento de singularidade
    
    M2_Inv = inv(W1)*transpose(M2)/((M2*inv(W1)*transpose(M2))+ep); % Eq. 12.276
    
    F = inv(K1)* M2_Inv * [FX;FY;TN]; % Eq. 12.275
    
    Th(1,1) = atan2(F(2),F(1));
    Th(2,1) = atan2(F(4),F(3));
    Th(3,1) = atan2(F(6),F(5));
    Th(4,1) = atan2(F(8),F(7));
    
    % Saturações
    Th  = Satura(Th,M_PI,-M_PI);
    
    %% Calculo do PWM
    M1 =[cos(Th(1))                       cos(Th(2))                       cos(Th(3))                       cos(Th(4));
         sin(Th(1))                       sin(Th(2))                       sin(Th(3))                       sin(Th(4));
        (-Ly*cos(Th(1))+Lx*sin(Th(1)))  (Ly*cos(Th(2))-Lx*sin(Th(2))) (Ly*cos(Th(3))+Lx*sin(Th(3))) (-Ly*cos(Th(4))-Lx*sin(Th(4)))];
    
    ep = 1e-5*eye(size(M1*transpose(M1)));
    
    M1_Inv = inv(W)*transpose(M1)/((M1*inv(W)*transpose(M1)) + ep);
    
    PWM = inv(K)*M1_Inv *[FX;FY;TN];
    
    % Saturações
    PWM = Satura(PWM,Pwmmax,Pwmmin);
  
    %% dinamica
%     th(: ,k+1) = Th.* RAD_TO_DEG;
%     pwm(:,k+1) = PWMtoNorm(PWM);
%     [pwm(:,k+1),th(:,k+1)] = DynamicsOfServosAndMotors(k+1,pwm,th);    
%     PWM = NormtoPWM(pwm(:,k+1));
%     Th =  th(:,k+1).* DEG_TO_RAD;
    
    %% Calculo ERRO
    FO = Aloc_Direta(Th.* RAD_TO_DEG,PWMtoNorm(PWM));
    
    ERR = ([FX;FY;TN] - FO)./[Fmax;Fmax;Nmax];
    Er = mean(ERR);
    i = i+1;
    if(i==100)
        i;
    end
end

PWM = PWMtoNorm(PWM);
Th = Th .* RAD_TO_DEG;

end