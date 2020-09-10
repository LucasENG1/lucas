function SetPointsCreation(Nome)
% Global variable(s)
global  SP Sim Time WP;

switch Nome
    case 'Cenario1'
        % Linear
        t = 0:1:360;
        X   = 1e-10+(140*ones(size(t)));
        Y   = 1e-10-(140*zeros(size(t)));
        Yaw = 0*atan(Y./X);
        
    case 'Cenario2'
        % Circular
        %% SP Circular HABILITAR LINE_OF_SIGHT
        Arc = 380;
        t   = Time;
        X   = 1e-10-(15*cosd((Arc/t(end))*t))+15;
        Y   = 1e-10-(15*sind((Arc/t(end))*t));
        Yaw = atan(Y./X);
        Sim.Current_X_Y_psi = [X(1); Y(1); -pi/2];

    case 'Cenario3'
        % SquareROI
        
    otherwise
        X = 0;
        Y = 0;
        Yaw = 0;  
end
WP = 2;
SP.XYZ = [X;Y;Yaw];

end