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
        Yaw = atan2(Y,X);
        Sim.Current_X_Y_psi = [X(1); Y(1); -pi/2];

    case 'Cena rio3'
        % SquareROI
        load('SP.mat');
        t = length(Time);
        Spt = length(Pose_real(1,:));
        A = 5;
        X   = Pose_real(2,1:A*Spt/t:Spt);
        Y   = Pose_real(1,1:A*Spt/t:Spt);
        Yaw = Pose_real(3,1:A*Spt/t:Spt);
        
        Sim.Current_X_Y_psi = [0;0; 0];
        
        clear Pose_real;
        
    case 'Cenario3'
        % SquareROI
%         Y   = [30 25 20 15 10 5 0 0  0  0  0  0  0  5 10 15 20 25 30 30 30 30 30 30];
%         X   = [0   0 0   0  0 0 0 5 10 15 20 25 30 30 30 30 30 30 30 25 20 15 10  0];
        df = 0.16;
        Y   = [[30:-df:0]                  zeros(1,length([30:-df:0])) [0:df:30]                      30*ones(1,length([30:-df:0])) 30*ones(1,length([30:-df:0]))];
        X   = [zeros(1,length([30:-df:0])) [0:df:30]                   30*ones(1,length([30:-df:0]))  [30:-df:0]                      zeros(1,length([30:-df:0]))+1e-5 ];
      
%         load('SP.mat');
%         Yaw = Pose_real(3,1:3:end);
%         clear Pose_real;
        Yaw = atan2(Y,X);
            
% Yaw = Yaw(131:1:end-100)+pi;
        
        Sim.Current_X_Y_psi = [X(1); Y(1); -pi/4];
        
%         clear Pose_real;
        
    otherwise
        X = 0;
        Y = 0;
        Yaw = 0;  
end
WP = 1;
SP.XYZ = [X;Y;Yaw];

% figure
% subplot(311)
% plot(X)
% subplot(312)
% plot(Y)
% subplot(313)
% plot(Yaw)
% 
% figure
% plot(X,Y)

end