%==========================================================================
% This function computes the outputs to aplly in all system actuators
%==========================================================================
function MotorsOutputs(stp)
%% Global variable(s)
global ROV SimOutput_Plot SP Sim

[F,PWM,theta_seno] = Murillo3(Sim.Current_pwm,Sim.Current_theta,Sim.F(:,stp),5);
% Força em X, Y e Torque de YAW Veiculo
SP.Fx_SP(stp)  = F(1);%Sim.Fx(stp);%
SP.Fy_SP(stp)  = F(2);%Sim.Fy(stp);%
SP.Yaw_SP(stp) = F(3);%Sim.Yaw(stp);%


%% a matriz calcula alguns angulos e estes devem ser aplicados ao veiculo,
% espera-se que as forças da matriz de alocação sejam iguais as de Sim
Sim.Current_theta = theta_seno;%[0;0;0;0];%
Sim.Current_pwm   = PWM;

ROV.theta_m1(stp) = theta_seno(1);
ROV.theta_m2(stp) = theta_seno(2);
ROV.theta_m3(stp) = theta_seno(3);
ROV.theta_m4(stp) = theta_seno(4);

SimOutput_Plot.Fm1_SP(stp) = PWM(1)*ROV.k1;
SimOutput_Plot.Fm2_SP(stp) = PWM(2)*ROV.k1;
SimOutput_Plot.Fm3_SP(stp) = PWM(3)*ROV.k1;
SimOutput_Plot.Fm4_SP(stp) = PWM(4)*ROV.k1;

SimOutput_Plot.OutPuts(:,stp) = [ROV.theta_m1(stp);ROV.theta_m2(stp);...
                                ROV.theta_m3(stp); ROV.theta_m4(stp)];



end