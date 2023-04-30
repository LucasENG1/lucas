function [Th,PWM] = Allocation_FossenSAE(FIn,Th,PWM)
global Fmax Nmax DEG_TO_RAD RAD_TO_DEG k1 M_PI Lx Ly;

FX = FIn(1);
FY = 0.0;
TN = FIn(3);

%% Dependendo da ordem de aloca��o, um dos conjuntos abaixo nao � usado
% PWM = NormtoPWM(PWM);%       // Converte o valor normalizado de 0  a 1 para PWM
% Th  = Th .* DEG_TO_RAD;%     // Convertendo de grau para Radianos

%% Pesos
w1 = 1; w3 = 1;
w2 = 1; w4 = 1;

K1 = diag([k1 k1 k1 k1 k1 k1]);
W1 = diag([w1 w1 w2 w2 w3 w3]);

M2 = [1   1   1   1   -1   -1 ;
      0   0   0   0    0    0 ;
     -Ly  Ly  Ly -Ly -Ly  Ly];

ep = 1e-15*eye(size(M2*transpose(M2)));

M2_Inv = inv(W1)*transpose(M2)/((M2*inv(W1)*transpose(M2))+ep); % Eq. 12.276

PWM = inv(K1)* (M2_Inv * [FX;0;TN]); % Eq. 12.275

% PWM(1,1) = sqrt(F(2)^2+F(1)^2);
% PWM(2,1) = sqrt(F(4)^2+F(3)^2);
% PWM(3,1) = sqrt(F(6)^2+F(5)^2);
% PWM(4,1) = sqrt(F(8)^2+F(7)^2);

% if(PWM(3,1)>1000)
%     PWM(4,1) = PWM(4,1)+(PWM(3,1)-1000);
%     PWM(3,1) = 1000;
% end
Th(1,1) = 0;% atan2(F(2),F(1));
Th(2,1) = 0;%  atan2(F(4),F(3));
Th(3,1) = 0;%  atan2(F(6),F(5));
Th(4,1) = 0;%  atan2(F(8),F(7));

% %% Satura��es
% Th(1,1) = Satura(Th(1,1) ,M_PI,-M_PI);
% Th(2,1) = Satura(Th(2,1) ,M_PI,-M_PI);
% Th(3,1) = Satura(Th(3,1) ,M_PI,-M_PI);
% Th(4,1) = Satura(Th(4,1) ,M_PI,-M_PI);

PWM = PWMtoNorm(PWM);
Th = Th .* RAD_TO_DEG;

end