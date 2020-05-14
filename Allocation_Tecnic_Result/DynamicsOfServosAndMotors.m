%=====================================================
% This function calculates the servos and motors dynamics considering a
% first order linear system
% ps.: Using 4-Order Runge-Kutta Integration Method
%=====================================================

function [PWM1,Theta1] = DynamicsOfServosAndMotors (stp,PWM,Theta)

    % Global Variables
    global APP Sim

    % Engine and Servos dynamics - Considering First-Order Linear System
    tau = [APP.tau_mt; APP.tau_mt; APP.tau_mt; APP.tau_mt; APP.tau_srv; APP.tau_srv; APP.tau_srv; APP.tau_srv];
    
    % ---------------------------------------------------------------------
    % Get the Servo and Motor Dynamics from new methodology
    % Reference signals of Servos and Motors to be considered before to apply their dynamics
    RefSignal    = [PWM(:,stp); Theta(:,stp)];
    
    if stp==1        
        ActualSignal = zeros(8,1);
    else
        ActualSignal = [PWM(:,stp-1); Theta(:,stp-1)];    
    end
    
    AuxVector = (RefSignal - ActualSignal)./tau;

    % 4-Order Runge-Kutta Integration Method
    s1 = AuxVector;
    s2 = AuxVector + (Sim.Ts/3)*s1;
    s3 = AuxVector + 2*(Sim.Ts/3)*s2;
    s4 = AuxVector + Sim.Ts*s3;

    AuxVector = ActualSignal + (Sim.Ts/8)*(s1 + 3*s2 + 3*s3 + s4);

    PWM1   = AuxVector(1:4);
    Theta1 = AuxVector(5:8);
end