function SetPointsCreation(Nome,Pose)
%% CRIA SPs SEMELHANTES AO QUE FOI PEDIDO PELO PLANEJADOR DE MISSÃO
global  SP;

switch Nome
    case 'Guinada'
        t   = 1:1:360;
        Y   = 1e-10+(120*zeros(size(t)));
        X   = 1e-10-(120*zeros(size(t)));
        Yaw = (pi*sind((360/(t(end)-20))*t));
    case 'Sway'
        A = 1;
        N = 1;
        t = 1:1:160;
        coefficients = polyfit([0, 76.82], [0, 67.79], 1);
        a = coefficients (1);
        b = coefficients (2);
        Y1   = a.*t(1:t(t==78)-N-1)+ b;
        
        coefficients = polyfit([79.82, 156.1], [66.5, 0], 1);
        a = coefficients (1);
        b = coefficients (2);
        Y2   = a.*t(t(t==78)+N:end)+ b;
        
        X   = 1e-10+(A*ones(size(t)));
        Y = [Y1 Y1(end)*ones(1,2*N) Y2];
        AX = Y;
        Y = X;
        X = AX;
        t = t-1;
        T = 8; % deslocamento de yaw
        Yaw = -atan2([X(1:length(Y)/2-T), -X(1:length(Y)/2) -X(1:T)],...
            [Y(1:(length(Y)/2)-1-T), -Y(length(Y)/2:end) -Y(1:T)])+...
            0*(pi/180);
        
    case {'Square_dif','SquareROI'}
        t   = 1:1:80;
        X1   = [30/18:30/18:30];
        x21  = 30:2/17:(32-2/17);
        x22  = 32:-2/6:(30+2/17);
        X2   = [x21 x22];
        X3   = [30:-30/20:30/20];
        X4   = 1.18:-1.18/19:1.18/19;%zeros(1,19);
        Y = [ X1 X2 X3 X4];
        
        Y1   = 1.705/17:1.705/17:1.705;
        Y2   = [31/19:31/19:31];
        Y3   = 31* ones(1,23);
        Y4   = [31:-31/19:31/19];
        X  = [ Y1 Y2 Y3 Y4 0 0];
        
        W1 = -10*ones(1,16);
        W2 = 110* ones(1,20);
        W3 = 204* ones(1,20);
        W4 = 307* ones(1,24);
        
        Yaw = [W1 W2 W3 W4];
        Yaw = Yaw.*pi/180;
        
    case 'Linear'
        t   = 1:1:360;
        Y   = [0 1e-10+(140*ones(size(t-1)))];
        X   = [0 1e-10-(140*zeros(size(t-1)))];
        Yaw = atan(Y./X);
        
    case 'Circular'
        A   = 49;        % Gira o circulo para igualar ao real
        t   = 1:1:360;
        X   = Pose(1,1)-(15*cosd((360/t(end))*t+A))+11.5;
        Y   = Pose(2,1)-(15*sind((360/t(end))*t+A))-18.8;
        Yaw = 2.73*atan2(Y,X);    % ganho de guinada para igualar ao real
%         Yaw(Yaw>pi) = Yaw(Yaw>pi)-2*pi; % ajuste para o ATAN2
        
    otherwise
        X   = 0;
        Y   = 0;
        Yaw = 0;
        t   = 0;
end

SP.X   = X;
SP.Y   = Y;
SP.Yaw = Yaw;
SP.t   = t;
end
