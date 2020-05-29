function [Th,PWM] = Alcacao_13_24(Fi,th,pwm,k)
global Fmax Nmax DEG_TO_RAD RAD_TO_DEG Lx Ly Pwmmax Pwmmin k1 k2 k3 k4 M_PI;

FX = Fi(1) * Fmax;
FY = Fi(2) * Fmax;
TN = Fi(3) * Nmax;

%% Dependendo da ordem de aloca��o, um dos conjuntos abaixo nao � usado
PWM = NormtoPWM(pwm(:,k));%       // Converte o valor normalizado de 0  a 1 para PWM
Th  = th(:,k) .* DEG_TO_RAD;%     // Convertendo de grau para Radianos

K1 = diag([k1  k2  k3  k4]);

M2 = [0             cos(Th(1))      0           cos(Th(2));
    0             sin(Th(1))      0           sin(Th(2));
    Ly*cos(Th(1)) Lx*sin(Th(1)) Ly*cos(Th(2)) -Lx*cos(Th(2)) ];

ep = 1e-15*eye(size(M2*transpose(M2))); % Res�duo para n�o deixar a matriz se tornar singular

M2_Inv = transpose(M2)/((M2*transpose(M2))+ep); % Eq. 12.276

F_mix = inv(K1)* M2_Inv * [FX;FY;TN]; % Eq. 12.275

PWM(1,1) = (F_mix(2)-F_mix(1))/2;
PWM(2,1) = (F_mix(3)+F_mix(4))/2;
PWM(3,1) = (F_mix(2)+F_mix(1))/2;
PWM(4,1) = (F_mix(4)-F_mix(3))/2;

PWM = Satura(PWM,Pwmmax,Pwmmin);

M1 = [(PWM(1,1)+PWM(3,1))         0                  (PWM(2,1)+PWM(4,1))      0                 ;
       0                        (PWM(1,1)+PWM(3,1))  0                       (PWM(2,1)+PWM(4,1));
      Ly*(PWM(1,1)-PWM(3,1)) Lx*(PWM(1,1)+PWM(3,1))  Ly*(PWM(2,1)-PWM(4,1)) -Lx*(PWM(2,1)+PWM(4,1))];

ep1 = 1e-10*eye(size(M1*transpose(M1))); % Res�duo para n�o deixar a matriz se tornar singular

M1_Inv = transpose(M1)/((M1*transpose(M1))+ep1); 

Th_mix = M1_Inv * [FX;FY;TN]; 
  
TH1 = atan2(Th_mix(2),Th_mix(1));
TH2 = atan2(Th_mix(4),Th_mix(3));

Th(1,1) = TH1;
Th(2,1) = TH2;
Th(3,1) = TH1;
Th(4,1) = TH2;

Th  = Satura(Th,M_PI,-M_PI);
%% Satura��es
% PWM = Satura(PWM,Pwmmax,Pwmmin);
% Th  = Satura(Th,M_PI,-M_PI);

PWM = PWMtoNorm(PWM);
Th = Th .* RAD_TO_DEG;

end