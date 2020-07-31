%% Alocação FOSSEN

close all; clear all; clc;

syms FT FX FY TN
syms k1 k2 k3 k4 Lx Ly
syms PWM1 PWM2 PWM3 PWM4
syms Th1 Th2 Th3 Th4

%% MATRIZ 1
display('PRIMEIRA PARTE SIMBOLICA')

M1 =[1   0    1     0     1    0     1     0;
     0   1    0     1     0    1     0     1;
    -Ly  Lx   Ly   -Lx    Ly   Lx   -Ly  -Lx];

K = diag([k1 k1 k2 k2 k3 k3 k4 k4]);

M1_Inv = transpose(M1)/(M1*transpose(M1));
% M1_Inv = pinv(M1);
% K_Inv  = transpose(K)/(K*transpose(K));
K_Inv = inv(K);

F = K_Inv *M1_Inv* [FX;FY;TN]

Theta(1,1) = atan2(F(2),F(1));
Theta(2,1) = atan2(F(4),F(3));
Theta(3,1) = atan2(F(6),F(5));
Theta(4,1) = atan2(F(8),F(7));

PWM(1,1) = sqrt(F(1)^2+F(2)^2);
PWM(2,1) = sqrt(F(3)^2+F(4)^2);
PWM(3,1) = sqrt(F(5)^2+F(6)^2);
PWM(4,1) = sqrt(F(7)^2+F(8)^2);


simplify(Theta)
simplify(PWM)


%% Matriz Direta
display('MATRIZ DIRETA')

syms PWM1 PWM2 PWM3 PWM4 Theta1 Theta2 Theta3 Theta4

F_out = [(k1*PWM1*cos(Theta1)+k2*PWM2*cos(Theta2)+k3*PWM3*cos(Theta3)+k4*PWM4*cos(Theta4));
    (k1*PWM1*sin(Theta1)+k2*PWM2*sin(Theta2)+k3*PWM3*sin(Theta3)+k4*PWM4*sin(Theta4));
    (Ly*(-k1*PWM1*cos(Theta1)+k2*PWM2*cos(Theta2)+k3*PWM3*cos(Theta3)-k4*PWM4*cos(Theta4))...
    +Lx*( k1*PWM1*sin(Theta1)-k2*PWM2*sin(Theta2)+k3*PWM3*sin(Theta3)-k4*PWM4*sin(Theta4)))]

Name = 'Final_FOSSEN2020';
nStates = length(F_out);
fileName = strcat(Name,'.mat');
save(fileName);

clear all

Name = 'Final_FOSSEN2020';
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