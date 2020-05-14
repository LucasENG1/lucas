%==========================================================================
% CATAMARAN MODEL PARAMETERS
%==========================================================================
function PhysicalProperties
% Global variable(s)
global ROV Sat APP Fmax L Lx Ly Nmax k1;

% Parametros construtivos
m   = 20.4;
xg  =   0;
Iz  = 4.0;

% Parametros relacionados ao desenho (plot) do barco
Loa   =   1.20;             % Comprimento do casco (metros)
dcx   =  Loa/2;
Bw1   =   0.20;              % Largura da linha dágua [m]
dcbby =  Lx - Bw1/2;
dceby = -dcbby;

% Parametros de massa adicionada
Xudot = -0.05*m ;%0*-11.2;
Yvdot = -m; %0*-68.1;
Yrdot =  0*-172.2;
Nrdot = -0.05*Iz; %0*-148.8;

% Parametros de amortecimento não linear e linear
Xuu   =    -0.5*m;     Xu    =  -0.25*m;%-9.6;
Yvv   =      -20*m;     Yv    =  -m;%-132.24;
Yvr   =   0*499e-5;     Yr    =  -0.05*m;
Nv    =   0*1.6543;
Nr    =   0*-65.60;
Nrv   =   0*166e-5;
Nvv   =   0*489e-5;
Nvr   =   0*5483e-5;
Nrr   =   0;

%% Momentos e produtos de Inércia
CG = [xg;0;0];

% Matriz de massa de corpo rígido   6.7 --- 7.12
IMrb = [ m       0       0; 
         0       m    m*xg; 
         0    m*xg      Iz];

% Matrix de massa adicionada    6.50 -- 7.14
IMra =  [ -Xudot    0         0; 
          0     -Yvdot    -Yrdot; 
          0     -Yrdot    -Nrdot]; 

%% Matriz de massa
IM = IMrb + IMra;                 % 6.48    7.8     

%% Constante de Tempo
settling_time_mt  = 0.03;
settling_time_srv = 0.05;

tau_mt  = settling_time_mt/5;    % Motors
tau_srv = settling_time_srv/5;   % Servos



%% Structure Creation
ROV = struct('mass',m,'ICG',Iz,'InertiaMatrix',IM,'IMrb',IMrb,'IMra',IMra,...
    'InverseInertia',inv(IM),'Xudot',Xudot,'Yvdot',Yvdot,'Yrdot',Yrdot,...
    'Nrdot',Nrdot,'Xuu', Xuu,'Yvv',Yvv,'Yvr',Yvr,'Nrv',Nrv,'Nvv',Nvv,...
    'Nvr', Nvr, 'Nrr', Nrr,'Xu', Xu, 'Yv', Yv, 'Yr', Yr, 'Nv', Nv,...
    'Nr', Nr, 'dcx', dcx,'dcbby', dcbby, 'dceby', dceby, 'CG', CG,...
    'Bw1',Bw1,'Loa',Loa,'Lx',Lx,'Ly',Ly,'k1',k1,'L',L);

APP = struct('tau_mt', tau_mt,'tau_srv',tau_srv);

end