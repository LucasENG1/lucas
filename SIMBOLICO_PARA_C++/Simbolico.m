clear all; close all; clc
syms Lx Ly FX FY TN k1 k2

M1 =[k1    k1     k2     k1      k1    k2  ;
    Lx      Lx      Lx   -Lx    -Lx     -Lx];


M1_Inv = transpose(M1)/(M1*transpose(M1));

F = M1_Inv* [FX;TN];

% Forças
PWM(1) = norm([F(2),F(1)]);
PWM(2) = norm([F(4),F(3)]);
PWM(3) = norm([F(6),F(5)]);
PWM(4) = norm([F(8),F(7)]);

% Theta
Theta(1) = atan2(F(2),F(1));
Theta(2) = atan2(F(4),F(3));
Theta(3) = atan2(F(6),F(5));
Theta(4) = atan2(F(8),F(7));