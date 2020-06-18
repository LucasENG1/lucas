function SetPointsCreation(Nome)
% Global variable(s)
global  SP Sim Time WP;

switch Nome
    case 'Figura'
        Y   = [0 5 20 40 50 30 10];
        X   = [0 25 25 25 2.5 2.5 0];
        Yaw = [0 0 0 0 0 0 0];
    case 'Guinada'
        t   = 0:1:360;
        Y   = 1e-10+(120*zeros(size(t)));
        X   = 1e-10-(120*zeros(size(t)));
        Yaw = (pi*sind((360/(t(end)-20))*t));
    case 'Sway'
        t = 0:1:180;
        A = 60;
        Y = 1e-10+(A*ones(size(t)));
        X = 1e-10-(A*zeros(size(t)));
        
        Yaw = [zeros(1,110) [0:pi/180:pi] pi*ones(size(t)) pi*ones(1,70)];
        Y   = [A*ones(size(Y)) A*(ones(1,180)) zeros(size(Y))];
        X = zeros(size(Y));     
        %         hold on; plot(Y,X,'Linewidth',2); plot(Y(1),X(1),'*r');axis equal
    case 'LinearX'
        t = 0:1:360;
        X   = 1e-10+(140*ones(size(t)));
        Y   = 1e-10-(140*zeros(size(t)));
        Yaw = 0*atan(Y./X);
        
    case 'LinearY'
        t = 0:1:360;
        Y   = 1e-10+(120*ones(size(t)));
        X   = 1e-10-(120*zeros(size(t)));
        Yaw = X;
        
    case 'Circular'
        %% SP Circular HABILITAR LINE_OF_SIGHT
        Arc=380;
        t   = Time;
        X   = 1e-10-(15*cosd((Arc/t(end))*t))+15;
        Y   = 1e-10-(15*sind((Arc/t(end))*t));
        Yaw = atan(Y./X);
        Sim.Current_X_Y_psi = [X(1); Y(1); -pi/2];
    case 'Oito'
        %% SP OITO
        t    = 0:.1:200;
        X21  = 1e-10-(10*cosd((360/(t(end)))*t))+35;
        Y21  = 1e-10-(10*sind((360/(t(end)))*t))-3.3;
        X22  = 1e-10+(10*cosd((360/(t(end)))*t))+67;
        Y22  = 1e-10-(10*sind((360/(t(end)))*t))-3.3;
        
        X = [X21(335:671) X22(1290:end) X22(1:720) X21(1310:end) X21(1:330)];
        Y = [Y21(335:671) Y22(1290:end) Y22(1:720) Y21(1310:end) Y21(1:330)];
        Yaw = atan2(Y,X);
        Sim.Current_X_Y_psi = [X(1); Y(1); Yaw(1)];
        %         Sim.Current_X_Y_psi = [30; -12;  -pi/4];
        
        X = X(1:20:end);
        Y = Y(1:20:end);
        Yaw = Yaw(1:20:end);
        %         hold on; plot(Y,X,'Linewidth',2); plot(Y(1),X(1),'*r');axis equal
    otherwise
        X = 0;
        Y = 0;
        Yaw = 0;
        
end
WP = 2;
SP.XYZ = [X;Y;Yaw];

end