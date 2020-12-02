function Leg = LegendLanguage(language)


switch language
    case 'Portugues'
        Leg.Algorit         = {'FCA','Conjunto Ativado','Pontos Interiores','Location','best'};
        Leg.Title1       = {'ISE Fx'};
        Leg.Title2       = {'ISE Fy'};
        Leg.Title3       = {'ISE $\tau_{n}$'};
        Leg.Xlabel       = {'Simula\{c}c\{~}ao'};
        Leg.Xlabel2      = {'Tempo (s)'};
        Leg.Ylabel      = {'For\{c}ca (N)'};
        Leg.Ylabel2      = {'Torque (N.m)'};
        
    case 'Ingles'
        Leg.Fx          = {'$F_x [N]$','Interpreter','latex'};
        Leg.Fy          = {'$F_y [N]$','Interpreter','latex'};
        Leg.Tn         = {'$\tau_{\psi}[N.m]$','Interpreter','latex'};
        
        Leg.Th1         = {'$\theta_1[^\circ]$','Interpreter','latex'};
        Leg.Th2         = {'$\theta_2[^\circ]$','Interpreter','latex'};
        Leg.Th3         = {'$\theta_3[^\circ]$','Interpreter','latex'};
        Leg.Th4         = {'$\theta_4[^\circ]$','Interpreter','latex'};
        
        Leg.PWM1         = {'$f_1 [N]$','Interpreter','latex'};
        Leg.PWM2         = {'$f_2 [N]$','Interpreter','latex'};
        Leg.PWM3         = {'$f_3 [N]$','Interpreter','latex'};
        Leg.PWM4         = {'$f_4 [N]$','Interpreter','latex'};
        
        Leg.Algorit      = {'Setpoint','FCA','Active-set','Interior-point','Location','best'};
        Leg.Title1       = {'ISE Fx'};
        Leg.Title2       = {'ISE Fy'};
        Leg.Title3       = {'ISE $\tau_{n}$'};
        Leg.Xlabel       = {'Simulation'};
        Leg.Xlabel2      = {'Time (s)'};
        Leg.Xlabel21      = {'Time [s]'};
        Leg.Ylabel       = {'Force (N)'};
        Leg.Ylabel2      = {'Torque (N.m)'};
    otherwise
        Leg = 0;
end
end