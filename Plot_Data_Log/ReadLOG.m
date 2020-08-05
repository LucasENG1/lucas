function [Velxyz_real,PoseNED_real,Tempo,Theta,PWM,F_IN,F_OUT,TempoAloc] = ReadLOG(Nome)
%% Carrega o LoG respectivo ai Nome definido
%% a1.mat RUIM
%% a2.mat CIRCULO
% -------- inicio: 8114 |
% -------- Final : 9394 |
% --------- yaw  : yaw_ini = -pi/4
%% a3.mat CIRCULO RUIM
%% a4.mat Reta com velocidade pequena
% -------- inicio: 5443 |
% -------- Final : 6780 |
% --------- yaw  : yaw_ini = pi/3
%% a5.mat
% -------- inicio: 781 |
% -------- Final : 1696 |
% --------- yaw  : yaw_ini = pi/3
%% a6.mat circulo talvez bom
%% a7.mat
% -------- inicio: 9800 |
% -------- Final : 13200 |
% --------- yaw  : yaw_ini = pi/4

switch Nome
    case 'Circular'
        load('b5.mat')
        Ang     = 140;          % ajuste de angulo para plotar a imagem melhor
        ini     = 3523;         % Inicio da leitura no log
        fim     = ini+1300;     % Final da leitura no log
        yaw_ini = -125*(pi/180); % Offset na guinada inicial (plot)
        
    case 'LinearX'
        load('b4.mat')
        Ang     = 140;          % ajuste de angulo para plotar a imagem melhor   
        ini     = 1662;         % Inicio da leitura no log
        fim     = 2688;         % Final da leitura no log
        yaw_ini = -130*(pi/180);  % Offset na guinada inicial (plot)
        
    case 'Sway'
        load('b6.mat')
        Ang = 153.3+180;
        ini     = 13480;        % Inicio da leitura no log
        fim     = ini+3050;     % Final da leitura no log
        yaw_ini = -166*(pi/180);           % Offset na guinada inicial (plot)
        
    case 'Sway2' % Melhor
        load('b6.mat')
        Ang = 1*(-28+180);      % ajuste de angulo para plotar a imagem melhor
        ini     = 8880;         % Inicio da leitura no log
        fim     = 12080;        % Final da leitura no log
        yaw_ini = 208 * pi/180; % Offset na guinada inicial (plot)
        
    case 'Oito'
        load('b1.mat')
        Ang     = -37.7;        % ajuste de angulo para plotar a imagem melhor
        ini     = 20750;        % Inicio da leitura no log
        fim     = ini+2400;     % Final da leitura no log
        yaw_ini = 45*(pi/180);%155*(pi/180); Offset na guinada inicial (plot)
        
    otherwise
        load('DIATOP/1BIN.mat')
        Ang     = 0;        % ajuste de angulo para plotar a imagem melhor
        ini     = 0;        % Inicio da leitura no log
        fim     = 'end';     % Final da leitura no log
        yaw_ini = 0*(pi/180);%155*(pi/180); Offset na guinada inicial (plot);
end
%% PARAMETROS DE DINAMICA DO VEICULO
Tempo = GRIN(ini:fim,2)/1000000;        % Tempo 
Py    = GRIN(ini:fim,5)/100;            % posição X no NED em cm (esta no py pelo plot)
Px    = GRIN(ini:fim,6)/100;            % posição Y no NED em cm
yaw   = GRIN(ini:fim,7)/1;              % Salva yaw em radianos
Vx    = GRIN(ini:fim,8)/100;            % Velocidade X no body
Vy    = GRIN(ini:fim,9)/100;            % Velocidade Y no body
Vyaw  = GRIN(ini:fim,10)*180/pi;        % Velocidade de Guinada (graus/s)

yaw = yaw - 0*yaw(1)+yaw_ini;             % Offset de yaw aplicado no sistema

% Correção de YAW para igualar ao ATAN2
yaw(yaw> pi) = yaw(yaw>pi)-2*pi ;        
yaw(yaw<-pi) = yaw(yaw<-pi)+2*pi;

% Quando o SP é em OITO existe ainda uma nova singularidade
switch Nome
    case 'Oito'
        yaw(yaw<-100*(pi/180)) = yaw(yaw<-100*(pi/180))+2*pi;
        
    case 'Sway'
        yaw = yaw-166*(pi/180);           % Offset na guinada inicial (plot)
        
    otherwise
        
end
Tempo = Tempo-Tempo(1);     % Começa o relógio do zero
Px    = Px - Px(1);         % Inicia todo mundo do zero
Py    = Py - Py(1);         % Inicia tudo mundo do zero

%% Monta os vetores
Pose_real1   = [Px';Py';yaw'];      % Vetor de Posição
Velxyz_real  = [Vx';Vy';Vyaw'];     % Vetor de Velocidade BODY

%% Rotação de Velocidade VN VE para Vx Vy
% for i=1:length(yaw)
%     Velxyz_real(:,i)  = NED2BF((Ang*pi/180),Vel_real1(:,i));
%     PoseNED_real(:,i) = NED2BF(-(Ang*pi/180),Pose_real1(:,i));
% end

%% Rotação para o corpo do veículo da pisção (para conferencia- APENAS)
for i=1:length(yaw)
    PoseNED_real(:,i) = NED2BF(-(Ang*pi/180),Pose_real1(:,i));
end

%% ========= PARAMETROS DE ALOCAÇÃO DO VEÍCULO ==================
TempoAloc = MAT(ini:fim,2)/1000000;         % Tempo
TempoAloc = TempoAloc - TempoAloc(1);   	% Começa o relógio do zero

% Angulos dos servomotores
Th1  = MAT(ini:fim,3);
Th2  = MAT(ini:fim,4);
Th3  = MAT(ini:fim,5);
Th4  = MAT(ini:fim,6);
Theta = [Th1';Th2';Th3';Th4'];

% PWM de comando dos motores
pwm1 = MAT(ini:fim,7);
pwm2 = MAT(ini:fim,8);
pwm3 = MAT(ini:fim,9);
pwm4 = MAT(ini:fim,10);
PWM = [pwm1' ;pwm2' ;pwm3' ;pwm4'];

% Forças de entrada da alocação
Fx = MAT(ini:fim,11);
Fy = MAT(ini:fim,12);
tn = MAT(ini:fim,13);
F_IN  = [Fx'; Fy'; tn'];

% Forças de saida da alocação
Fxo   = MAT(ini:fim,14);
Fyo   = MAT(ini:fim,15);
tno   = MAT(ini:fim,16);
F_OUT = [Fxo'; Fyo'; tno'];



end