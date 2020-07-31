function R = NormtoPWM(val)

global Pwmmax Pwmmin
%      Entra um valor de 0 a 1 e sai um PWM
R =  val*(Pwmmax-Pwmmin) + Pwmmin;
end