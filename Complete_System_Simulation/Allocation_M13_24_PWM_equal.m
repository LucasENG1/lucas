function [Th,PWM] = Allocation_M13_24_PWM_Equal(F,Th,PWM)
global DEG_TO_RAD RAD_TO_DEG k1 M_PI Lx Pwmmax Pwmmin;

FX = F(1);
FY = F(2);
TN = F(3);

%% Dependendo da ordem de alocação, um dos conjuntos abaixo nao é usado
PWM = NormtoPWM(PWM);%       // Converte o valor normalizado de 0  a 1 para PWM
Th  = Th .* DEG_TO_RAD;%     // Convertendo de grau para Radianos

Th1 = Th(1);
Th2 = Th(2);
Th3 = Th(3);
Th4 = Th(4);

PWM1 = PWM(1);
PWM2 = PWM(2);
PWM3 = PWM(3);
PWM4 = PWM(4);

% =========================================================================
K1 = diag(k1);

M2 = [cos(Th1) + cos(Th2);
      sin(Th1) + sin(Th2);
      Lx*(sin(Th1) - sin(Th2))];
  
% Resíduo para não deixar a matriz se tornar singular
ep = 1e-15*eye(size(M2*transpose(M2))); 

M2_Inv = transpose(M2)/((M2*transpose(M2))+ep); % Eq. 12.276

F_mix = inv(K1)* M2_Inv * [FX;FY;TN]; % Eq. 12.275

PWM1 = (F_mix)/2;
PWM2 = (F_mix)/2;
PWM3 = (F_mix)/2;
PWM4 = (F_mix)/2;

PWM1 = Satura(PWM1,Pwmmax,Pwmmin);
PWM2 = Satura(PWM2,Pwmmax,Pwmmin);
PWM3 = Satura(PWM3,Pwmmax,Pwmmin);
PWM4 = Satura(PWM4,Pwmmax,Pwmmin);

% =========================================================================
M1 = [1      0      1      0 ;
      0      1      0      1 ;
      0      Lx     0     -Lx];
  
% Resíduo para não deixar a matriz se tornar singular  
ep1 = 1e-10*eye(size(M1*transpose(M1))); 

M1_Inv = transpose(M1)/((M1*transpose(M1))+ep1); 

Th_mix = M1_Inv * [FX;FY;TN]; 
  
TH1 = atan2(Th_mix(2),Th_mix(1));
TH2 = atan2(Th_mix(4),Th_mix(3));

Th1 = TH1;
Th2 = TH2;
Th3 = TH1;
Th4 = TH2;

Th1  = Satura(Th1,M_PI,-M_PI);
Th2  = Satura(Th2,M_PI,-M_PI);
Th3  = Satura(Th3,M_PI,-M_PI);
Th4  = Satura(Th4,M_PI,-M_PI);
% =========================================================================

PWM = [PWM1;PWM2;PWM3;PWM4];
PWM = PWMtoNorm(PWM);

Th  = [Th1;Th2;Th3;Th4];
Th = Th .* RAD_TO_DEG;

end