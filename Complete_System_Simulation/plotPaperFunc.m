function Plot(Nboats)

%% plota a parte Executada em campo do sistema
load('logcircle.mat')
ini = 1430+179+13;
fim = 2045;
% 
% load('frente.mat')
% ini = 1;
% fim = 418;

lat = GPS(ini:fim,8);
lon = GPS(ini:fim,9);
T = GPS(ini:fim,2)';

% load('circulo2.mat')
% ini2 = 2554+245;
% fim2 = 3129;
% lat = GPS(ini2:fim2,8);
% lon = GPS(ini2:fim2,9);
% T   = GPS(ini2:fim2,2)';

%% Parametros de construção
Fmax = 2.6*9.81*4; % Força maxíma real
Pwmmax = 1001.0;
Pwmmin = 1.0;
k1 = (Fmax/4.0)/(Pwmmax-Pwmmin);
L  = 0.586;
Nmax = L*Fmax;
Lx = L*cos(pi/4.0);
Ly = L*cos(pi/4.0);
Loa   =   1.20;             % Comprimento do casco (metros)
dcx   =  Loa/2;
Bw1   =   0.20;              % Largura da linha dágua [m]
dcbby =  Lx - Bw1/2;
dceby = -dcbby;

global ROV DEG_TO_RAD RAD_TO_DEG Pose_real Time_Real yawIni Vel_real;

RAD_TO_DEG = 180/pi;
DEG_TO_RAD = 1/ RAD_TO_DEG;

ROV = struct('dcx', dcx,'dcbby', dcbby, 'dceby', dceby,'Bw1',Bw1,'Loa',Loa,'Lx',Lx,'Ly',Ly,'L',L,'k1',k1);

%% Sincronizar por tempo
% yaw
Tyaw = ATT(:,2);
yaw = Sincroniza(T,Tyaw,ATT(:,8));
% Velocidades
TVN = NKF1(:,2);
VN = Sincroniza(T,TVN,NKF1(:,6));
VE = Sincroniza(T,TVN,NKF1(:,7));
VD = Sincroniza(T,TVN,NKF1(:,8));
%%
yaw = (yaw) .* DEG_TO_RAD;
yaw = corrigeyaw(yaw);
%%Acredito que esta rotação esteja certa e tenha que ser feita antes de corrigir o yaw
for i =1:length(yaw)
    Vel_real(:,i) = NED2BF(yaw(i),[VN(i);VE(i);VD(i)]);
end


 yaw = yaw - yaw(1)+ yawIni;
%  Vel_real = [VN;VE;VD];

[Py, Px] = LatLonToMeters2(lat,lon);
hold on;
plot(Px,Py,'r','linewidth',2); grid on;
axis equal

Pose_real = [Px';Py';yaw];
T = T - T(1);
Time_Real =(T/1000000); %conversão

FiguraArtigo(Nboats,Pose_real);


end






