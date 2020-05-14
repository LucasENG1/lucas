function ParametrosBarco()
global ROV DEG_TO_RAD RAD_TO_DEG Nmax Fmax;
%% Defini��es
Fmax = 2.1*10*4; % For�a max�ma real
L    = 0.54;
Nmax = L*Fmax;

Pwmmax = 1001.0;
Pwmmin = 1.0;
k1 = (Fmax/4.0)/(Pwmmax-Pwmmin);

%% Parametros de constru��o

Lx = L*cos(pi/4.0);
Ly = L*cos(pi/4.0);
Loa   =   1.20;             % Comprimento do casco (metros)
dcx   =  Loa/2;
Bw1   =   0.20;             % Largura da linha d�gua [m]
dcbby =  Lx - Bw1/2;
dceby = -dcbby;

RAD_TO_DEG = 180/pi;
DEG_TO_RAD = 1/ RAD_TO_DEG;
ROV = struct('dcx', dcx,'dcbby', dcbby, 'dceby', dceby,...
    'Bw1',Bw1,'Loa',Loa,'Lx',Lx,'Ly',Ly,'L',L,'k1',k1);

end