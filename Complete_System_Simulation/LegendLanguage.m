function Leg = LegendLanguage(language)


switch language
    case 'Portugues'
        Leg.p3D         = {'Caminho a desenvolver','Caminho desenvolvido','NumColumns',2,'Location','northoutside'};
        Leg.posicaoX3L  = {'Setpoint em $X$','Simula\c{c}\~{a}o em $X$','Location','best'};
        Leg.posicaoY3L  = {'Setpoint em $Y$','Simula\c{c}\~{a}o em $Y$','Location','best'};
        Leg.posicaoYaw3L= {'Setpoint em $\psi$','Simula\c{c}\~{a}o em $\psi$','Location','best'};
        
        Leg.VelXY       = {'Velocidade $X$','Velocidade $Y$''Location','best'};
        Leg.VelYaw      = {'Simula\c{c}\~{a}o em $\psi$','Location','northeast'};
        
        Leg.VelX3L      = {'Setpoint em $X$','Simula\c{c}\~{a}o em $X$','Location','northeast'};
        Leg.VelY3L      = {'Setpoint em $Y$','Simula\c{c}\~{a}o em $Y$','Location','northeast'};
        Leg.VelYaw3L    = {'Setpoint em $\psi$','Simula\c{c}\~{a}o em $\psi$','Location','northeast'};
        Leg.AlocacaoX   = {'$F_x$ Desejado','$F_x$  Alocado','Location','best'};
        Leg.AlocacaoY   = {'$F_y$ Desejado','$F_y$  Alocado','Location','best'};
        Leg.AlocacaoPsi = {'$\tau_{\psi}$ Desejado','$\tau_{\psi}$  Alocado','Location','best'};
        
        Leg.ServoAngle1  = {'Servo motor 1','Location','northeast'};
        Leg.ServoAngle2  = {'Servo motor 2','Location','northeast'};
        Leg.ServoAngle3  = {'Servo motor 3','Location','northeast'};
        Leg.ServoAngle4  = {'Servo motor 4','Location','northeast'};
                       
        Leg.ServoPWM1  = {'Motor 1','Location','northeast'};
        Leg.ServoPWM2  = {'Motor 2','Location','northeast'};
        Leg.ServoPWM3  = {'Motor 3','Location','northeast'};
        Leg.ServoPWM4  = {'Motor 4','Location','northeast'};
                       
        Leg.YSA     = {'\^ Angulo (Grau)'};
        Leg.YPWM     = {'PWM (\%)'};
        Leg.X3D     = {'X (m)'};
        Leg.Y3D     = {'Y (m)'};
        Leg.XP3L    = {'Tempo (s)'};
        Leg.YP3L    = {'Posi\c{c}\~{a}o (m)'};
        Leg.yaw3L   = {'\^ Angulo (Grau)'};
        Leg.Forca   = {'For\c{c}a (N)'};
        Leg.Torque  = {'Torque (N.m)'};
        Leg.YV3L    = {'Velocidade (m/s)'};
        Leg.YYaw3L  = {'Velocidade Angular (Grau/s)'};
        
    case 'Ingles'
        Leg.p3D2         = {'Path to follow','Developed path'};
        Leg.p3D          = {'Path to follow','Developed path','NumColumns',2,'Location','northoutside'};
        Leg.posicaoX3L   = {'$X$ waypoint','$X$ response','Location','best'};
        Leg.posicaoY3L   = {'$Y$ waypoint','$Y$ response','Location','best'};
        Leg.posicaoYaw3L = {'$\psi$ waypoint','$\psi$ response','Location','best'};
        
        Leg.VelXY        = {'$X$ speed','$Y$ speed','Location','best'};
        Leg.VelYaw     = {'$\psi$ speed','Location','northeast'};
        
        Leg.VelX3L       = {'$X$ waypoint','Location','northeast'};
        Leg.VelY3L       = {'$Y$ waypoint','Location','northeast'};
        Leg.VelYaw3L     =  {'$\psi$ waypoint','$\psi$ response','Location','northeast'};
        Leg.AlocacaoX    = {'$F_x$ desired','$F_x$ allocated','Location','best'};
        Leg.AlocacaoY    = {'$F_y$ desired','$F_y$ allocated','Location','best'};
        Leg.AlocacaoPsi  = {'$\psi$ desired','$\psi$ allocated','Location','best'};
        
        Leg.ServoAngle  = {'Servomotor 1','Servomotor 2','Servomotor 3','Servomotor 4','Location','north'};
        
        Leg.ServoAngle1  = {'Servomotor 1','Location','northeast'};
        Leg.ServoAngle2  = {'Servomotor 2','Location','northeast'};
        Leg.ServoAngle3  = {'Servomotor 3','Location','northeast'};
        Leg.ServoAngle4  = {'Servomotor 4','Location','northeast'};
        
        Leg.ServoPWM  = {'Motor 1','Motor 2','Motor 3','Motor 4','Location','best'};
        
        Leg.ServoPWM1  = {'Motor 1','Location','best'};
        Leg.ServoPWM2  = {'Motor 2','Location','best'};
        Leg.ServoPWM3  = {'Motor 3','Location','best'};
        Leg.ServoPWM4  = {'Motor 4','Location','best'};
        
        Leg.YSA     = {'Angle (Degree)'};
        Leg.YPWM     = {'PWM (\%)'};
        Leg.X3D    = {'X (m)'};
        Leg.Y3D    = {'Y (m)'};
        Leg.XP3L   = {'Time (s)'};
        Leg.YP3L   = {'Position (m)'};
        Leg.yaw3L  = {'Angle (Degree)'};
        Leg.Forca  = {'Force (N)'};
        Leg.Torque = {'Torque (N.m)'};
        Leg.YV3L   = {'Speed (m/s)'};
        Leg.YYaw3L = {'Angular speed (Deg/s)'};
        
    otherwise
        Leg = 0;
end
end