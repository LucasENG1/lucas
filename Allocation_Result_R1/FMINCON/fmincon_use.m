function [Th,PWM, fval] = fmincon_use (CTRL_IN,Xin,j)
              
% Maximum PWM Variation
MaxPWM = 1000.0;

lb  = [     0;      0;      0;      0; -pi; -pi; -pi; -pi];
ub  = [MaxPWM; MaxPWM; MaxPWM; MaxPWM;  pi;  pi;  pi;  pi];
x0  = Xin(:,j-1);
A   = [];
b   = [];
Aeq = [];
beq = [];
nolncol = [];

emax= 1e-3;
opt = optimoptions('fmincon','Algorithm','interior-point','TolFun', emax, 'MaxIter', 20); % run active-set algorithm
opt.Display = 'notify';
% [x,fval,exitflag,output,population,scores]= ga(@(x)dhxxx(x,G(1),G(2),G(3),G(4),G(5)),5,[],[],[],[],lb,ub,[],options);
[x, fval ,exitflag, output] = fmincon(@(x)fob_function(x,CTRL_IN),x0,A,b,Aeq,beq,lb,ub,nolncol,opt);

% % % [T,PM] = DynamicsOfServosAndMotors(j,[Xin(5:8,:),x(5:8)],[Xin(1:4,:),x(1:4)]);
% % % 
% % % Th  = T;
% % % PWM = PM;%x(1:4);

Th  = x(5:8);
PWM = x(1:4);

end