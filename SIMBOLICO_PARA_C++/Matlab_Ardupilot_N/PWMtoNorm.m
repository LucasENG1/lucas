function R = PWMtoNorm(pwm)

global Pwmmax Pwmmin
%     /// Entra um valor de PWM e sai de 0 a 1

V = (pwm - Pwmmin)/(Pwmmax-Pwmmin);

R =  constrain_float(V,0.0,1.0);

end