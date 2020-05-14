function [PWM1,Theta1] = PWM_MotorsAndServos_Dynamics_TRUAV (stp,PWM,Theta)

% Calculates the Dynamics Responses of Servos and Motors, due to their Characteristics
[PWM1,Theta1]= DynamicsOfServosAndMotors(stp,PWM,Theta);


end