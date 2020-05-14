function plotPaperFunc ()
load('logcircle.mat')
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

global ROV DEG_TO_RAD RAD_TO_DEG;

RAD_TO_DEG = 180/pi;
DEG_TO_RAD = 1/ RAD_TO_DEG;

ROV = struct('dcx', dcx,'dcbby', dcbby, 'dceby', dceby,'Bw1',Bw1,'Loa',Loa,'Lx',Lx,'Ly',Ly,'L',L,'k1',k1);
%%
ini = 1430+179+13;
fim = 2045;

lat = GPS(ini:fim,8);
lon = GPS(ini:fim,9);

%% Sincronizar por tempo

T = GPS(ini:fim,2)';
Tyaw = ATT(:,2);
ax=1;

for i=1:length(T)
    for j=ax:length(Tyaw)
        if(Tyaw(j)>T(i))
            yaw(i) =ATT(j-1,8);
            ax = j;
            j = length(Tyaw);
        end
    end
end

%%
yaw = yaw.* DEG_TO_RAD;
yaw = yaw - yaw(1);

[Px, Py] = LatLonToMeters2(lat,lon);

plot(Px,Py,'r','linewidth',2); grid on;
axis equal
hold on;

FiguraArtigo(10,[Px';Py';yaw]);
grid on; hold off;
legend('Executed')
title('ASV position')


end






