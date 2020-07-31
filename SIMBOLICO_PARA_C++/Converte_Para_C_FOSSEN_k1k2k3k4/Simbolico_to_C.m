close all; clear all; clc;

syms FT FX FY TN
syms k1 k2 k3 k4 Lx Ly
syms PWM1 PWM2 PWM3 PWM4
syms Th1 Th2 Th3 Th4

% pesos
w1 = 1; w2 = 1; w3 = 1; w4 = 1;
W = diag([w1 w2 w3 w4]);

ep = diag([1 1 1]).*1e-3;

%% MATRIZ 1
display('PRIMEIRA PARTE SIMBOLICA')

%% Calculo do Angulo
M1 =  [PWM1      0         PWM2      0         PWM3     0         PWM4       0   ;
    0         PWM1      0         PWM2      0        PWM3      0          PWM4;
    -Ly*PWM1    Lx*PWM1   Ly*PWM2  -Lx*PWM2  Ly*PWM3  Lx*PWM3  -Ly*PWM4    -Lx*PWM4];

K = diag([k1 k1 k1 k1 k1 k1 k1 k1]);

M1_Inv = transpose(M1)/(M1*transpose(M1));%+1e-5*eye(size(M1*transpose(M1))));

F = inv(K)*M1_Inv *[FX;FY;TN];

Theta(1,1) = atan2(F(2),F(1));
Theta(2,1) = atan2(F(4),F(3));
Theta(3,1) = atan2(F(6),F(5));
Theta(4,1) = atan2(F(8),F(7));

simplify(Theta)

%% SEGUNDA PARTE SIMBOLICA
display('SEGUNDA PARTE SIMBOLICA')

M2 =[cos(Th1)                         cos(Th2)                       cos(Th3)                       cos(Th4);
    sin(Th1)                         sin(Th2)                       sin(Th3)                       sin(Th4);
    (-Ly*cos(Th1)+Lx*sin(Th1))  (Ly*cos(Th2)-Lx*sin(Th2)) (Ly*cos(Th3)+Lx*sin(Th3)) (-Ly*cos(Th4)-Lx*sin(Th4))];

K1 = diag([k1 k1 k1 k1]);

M2_Inv = inv(W)*transpose(M2)/((M2*inv(W)*transpose(M2))+ep); % Eq. 12.276

PWM = inv(K1)* M2_Inv * [FX;FY;TN]; % Eq. 12.275

PWM = simplify(PWM)

%% Matriz Direta
display('MATRIZ DIRETA')

syms PWM1 PWM2 PWM3 PWM4 Theta1 Theta2 Theta3 Theta4

F_out = [(k1*PWM1*cos(Theta1)+k2*PWM2*cos(Theta2)+k3*PWM3*cos(Theta3)+k4*PWM4*cos(Theta4));
    (k1*PWM1*sin(Theta1)+k2*PWM2*sin(Theta2)+k3*PWM3*sin(Theta3)+k4*PWM4*sin(Theta4));
    (Ly*(-k1*PWM1*cos(Theta1)+k2*PWM2*cos(Theta2)+k3*PWM3*cos(Theta3)-k4*PWM4*cos(Theta4))...
    +Lx*( k1*PWM1*sin(Theta1)-k2*PWM2*sin(Theta2)+k3*PWM3*sin(Theta3)-k4*PWM4*sin(Theta4)))]


Name = 'Final_Mat';
nStates = length(F_out);
fileName = strcat(Name,'.mat');
save(fileName);

clear all

Name = 'Final_Mat';
%% Gravando tudo em arquivo TXT
fileName = strcat(Name,'.mat');
load(fileName);
fileName = strcat(Name,'.txt');
fid = fopen(fileName,'wt');
fprintf(fid,'\n');
for rowIndex = 1:numel(PWM)
    string = char(PWM(rowIndex));
    fprintf(fid,'PWM(%d) = %s;\n',rowIndex,string);
end
fprintf(fid,'\n\n');

for rowIndex = 1:numel(Theta)
    string = char(Theta(rowIndex));
    fprintf(fid,'theta(%d) = %s;\n',rowIndex,string);
end
fprintf(fid,'\n\n');

for rowIndex = 1:numel(F_out)
    string = char(F_out(rowIndex));
    fprintf(fid,'F_out(%d) = %s;\n',rowIndex,string);
end
fprintf(fid,'\n');

fclose(fid);

ConvertToM(Name);
ConvertToC(Name);