function SetPointsCreation(Nome,Pose)
%% CRIA SPs SEMELHANTES AO QUE FOI PEDIDO PELO PLANEJADOR DE MISSÃO

% Global variable(s)
global  SP Sim;

%% SLOWER Loop
% t = Time;
% t = 0:1:360;

% P1 = Polinomio(000,020,0,+20,0,0,Sim.Ts,Sim.tFinal);
% P2 = Polinomio(040,080,0,-40,0,0,Sim.Ts,Sim.tFinal);
% P3 = Polinomio(120,160,0,+20,0,0,Sim.Ts,Sim.tFinal);

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
        
    case 'LinearX'
        t   = 1:1:360;
        Y   = [0 1e-10+(140*ones(size(t-1)))];
        X   = [0 1e-10-(140*zeros(size(t-1)))];
        Yaw = atan(Y./X);
        
    case 'Circular'
        % HABILITAR LINE_OF_SIGHT
        A   = 49;        % Gira o circulo para igualar ao real
        t   = 1:1:360;
        X   = Pose(1,1)-(15*cosd((360/t(end))*t+A))+10.25;
        Y   = Pose(2,1)-(15*sind((360/t(end))*t+A))+11.25;
        Yaw = 2.73*atan2(Y,X);    % ganho de guinada para igualar ao real
        Yaw(Yaw>pi) = Yaw(Yaw>pi)-2*pi; % ajuste para o ATAN2
        
    case 'Oito'
        A   = 0;
        p1  = 841;
        t   = 0:.1:200;
        %% SP OITO
        X21  = 1e-10-(10*cosd((360/(t(end)))*t+A))+35;
        Y21  = 1e-10-(10*sind((360/(t(end)))*t+A))-3.3;
        X22  = 1e-10+(10*cosd((360/(t(end)))*t+A))+67;
        Y22  = 1e-10-(10*sind((360/(t(end)))*t+A))-3.3;
        
        Y = [X21(335:671) X22(1290:end) X22(1:720) X21(1310:end) X21(1:330)];
        X = [Y21(335:671) Y22(1290:end) Y22(1:720) Y21(1310:end) Y21(1:330)];
        Y = Y -74.35-0.18;
        X = X -2 -0.275 -0.03;
        Yaw = atan2(Y,X);
        Yaw = [Yaw(1) Yaw];
        x1 = X(1:p1);
        x1 = [X(p1:end) x1];
        X = x1;
        
        y1 = Y(1:p1);
        y1 = [Y(p1:end) y1];
        Y = y1;
        
        X = X(end:-1:1);
        Y = Y(end:-1:1);
        
        Sim.Current_X_Y_psi = [X(1); Y(1); Yaw(1)];
        t  = 123.2/length(X):123.2/length(X):123.2;
    otherwise
        X = 0;
        Y = 0;
        Yaw = 0;
        t=0;
end

% Plot para conferencia do SP criado
%  hold on; plot(Y,X,'Linewidth',2); plot(Y(1),X(1),'*r');axis equal

SP.X = X;
SP.Y = Y;
SP.Yaw = Yaw;
SP.t = t;
end

% SP.X = X(1:length(X)/20:end);
% SP.Y = Y(1:length(Y)/20:end);
% SP.Yaw = Yaw(1:length(Yaw)/20:end);
%%
% sp = [10 10 10 10 10  1  0 -10;
%       5  20 40 50 90 30 10 25];

% SP.X = 5*sp(1,:)/2;
% SP.Y = sp(2,:);
% SP.Yaw = zeros(1,length(SP.X));
%%

% SP.X = [100 ];%15 20 25 30 10];
% SP.Y = [200 ];%12 23 25 30  0];
% Sim.Current_X_Y_psi = [SP.X(1) SP.Y(1) SP.Yaw(1)]';
