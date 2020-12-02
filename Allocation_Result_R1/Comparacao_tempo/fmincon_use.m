function [Th,PWM, fval,Erro_part1] = fmincon_use (CTRL_IN,Xin,j,opt)

% Maximum PWM Variation
MaxPWM = 1000.0;

iteracao_Maxim = 16;
Erro_part1 = [];

lb  = [     0;      0;      0;      0; -pi; -pi; -pi; -pi];
ub  = [MaxPWM; MaxPWM; MaxPWM; MaxPWM;  pi;  pi;  pi;  pi];
x0  = Xin(:,j-1);
A   = [];
b   = [];
Aeq = [];
beq = [];
nolncol = [];

while(j <= iteracao_Maxim)
    j = j + 1;
    
    [x, fval] = fmincon(@(x)fob_function(x,CTRL_IN),x0,A,b,Aeq,beq,lb,ub,nolncol,opt);
    x0 = x;
    Erro_part1(end+1) = fval;
    
end
% % % [T,PM] = DynamicsOfServosAndMotors(j,[Xin(5:8,:),x(5:8)],[Xin(1:4,:),x(1:4)]);
% % %
% % % Th  = T;
% % % PWM = PM;%x(1:4);

Th  = x(5:8);
PWM = x(1:4);

end