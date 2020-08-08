%% Alocação FOSSEN
%% Leva em consideração a diferença do CG

close all; clear all; clc;


syms FT FX FY TN
syms k1 k2 k3 k4 Lx1 Lx2 Ly
syms PWM1 PWM2 PWM3 PWM4
syms Th1 Th2 Th3 Th4

%% MATRIZ 1
display('PRIMEIRA PARTE SIMBOLICA')

M1 =[1   1    1    1 ;
   -Ly   Ly   Ly   -Ly ];

K = diag([k1 k2 k3 k4]);

M1_Inv = transpose(M1)/(M1*transpose(M1));
% M1_Inv = pinv(M1);
% K_Inv  = transpose(K)/(K*transpose(K));
K_Inv = inv(K);

F = K_Inv *M1_Inv* [FX;TN]

PWM(1,1) = F(1);
PWM(2,1) = F(2);
PWM(3,1) = F(3);
PWM(4,1) = F(4);

simplify(PWM)


%% Matriz Direta
display('MATRIZ DIRETA')

syms PWM1 PWM2 PWM3 PWM4 Theta1 Theta2 Theta3 Theta4

Name = 'Final_DIFERENCIAL';
% nStates = length(F_out);
fileName = strcat(Name,'.mat');
save(fileName);

clear all

Name = 'Final_DIFERENCIAL';
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

% for rowIndex = 1:numel(Theta)
%     string = char(Theta(rowIndex));
%     fprintf(fid,'theta(%d) = %s;\n',rowIndex,string);
% end
% fprintf(fid,'\n\n');
% 
% for rowIndex = 1:numel(F_out)
%     string = char(F_out(rowIndex));
%     fprintf(fid,'F_out(%d) = %s;\n',rowIndex,string);
% end
fprintf(fid,'\n');

fclose(fid);

ConvertToM(Name);
ConvertToC(Name);