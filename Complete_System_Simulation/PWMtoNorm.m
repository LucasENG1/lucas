function out = PWMtoNorm(V)
% converte o valor V de uma faixa de 0 a 1 para uma faixa de pwmmin a pwmmax

global Pwmmax Pwmmin;

out = (V - Pwmmin)/(Pwmmax - Pwmmin) ;

out = Satura(out,1,0);

end