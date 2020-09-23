function [Velxyz_real,PoseNED_real,Theta,PWM,F_IN,F_OUT,Tempo,TempoAloc,TempoVel] = ReadLOG(Nome)

switch Nome
    case 'Cenario1'
%         Linear
        load('LOG_Artigo/b4.mat') ;
        Ang     = -140*(pi/180);    % ajuste de angulo para plotar a imagem melhor
        ini     = 1612;             % Inicio da leitura no log
        fim     = ini+1162;         % Final da leitura no log
%         fim     = ini+1162; 
    case 'Cenario2'
        %Circular
        load('LOG_Artigo/a2.mat') ;
        Ang     = 0*-102 *(pi/180);          % ajuste de angulo para plotar a imagem melhor
        ini     = 7950;         % Inicio da leitura no log
        fim     = 9430;         % Final da leitura no log
        
    case 'Cenario3'
        % SquareROI
        load('LOG_Artigo/Square_31_08.mat')
        Ang     = 0*(pi/180);   % ajuste de angulo para plotar a imagem melhor
        ini     = 4700;         % Inicio da leitura no log
        fim     = ini+3100;     % Final da leitura no log
        
    case 'ComparaFinal3dof'
        % Square 3DOF
        load('LOG_Artigo/log2.mat')
        Ang     = 0 * (pi/180);         % ajuste de angulo para plotar a imagem melhor
        ini     = 12300;                % Inicio da leitura no log
        fim     = ini+1600;             % Final da leitura no log
        
    case 'ComparaFinal2dof'
        load('LOG_Artigo/log2.mat')
        Ang     = 0*(pi/180);       % ajuste de angulo para plotar a imagem melhor
        ini     = 10000;            % Inicio da leitura no log
        fim     = ini+1800;         % Final da leitura no log
        
    otherwise
        
end

%%  ========= PARAMETROS DE POSIÇÃO DO VEÍCULO ==================
Tempo = GRIN(ini:fim,2)/1000000;        % Tempo
Py    = GRIN(ini:fim,5)/100;            % posição X no NED em cm (esta no py pelo plot)
Px    = GRIN(ini:fim,6)/100;            % posição Y no NED em cm
yaw   = GRIN(ini:fim,9)/100;            % Salva yaw em radianos

for q = 1:length(yaw)
   yaw(q) = mod(yaw(q),360)* (pi/180);
   if(yaw(q)> pi)
       yaw(q) = yaw(q)-2*pi ;
   end
   if(yaw(q)<-pi)
       yaw(q) = yaw(q)+2*pi;
   end
end

Tempo = Tempo-Tempo(1);     % Começa o relógio do zero
Px    = Px - Px(1);         % Inicia todo mundo do zero
Py    = Py - Py(1);         % Inicia tudo mundo do zero

%%  ========= PARAMETROS DE VELOCIDADE DO VEÍCULO ==================
TempoVel = AFSN(ini/2:fim/2,2)/1000000;    % Tempo
Vx       = AFSN(ini/2:fim/2,8)/100;        % Velocidade X no body
Vy       = AFSN(ini/2:fim/2,9)/100;        % Velocidade Y no body
Vyaw     = AFSN(ini/2:fim/2,10).*180/pi;   % Velocidade de Guinada (graus/s)

TempoVel = TempoVel - TempoVel(1);         % Começa o relógio do zero

% yaw   = (yaw-yaw(1));
% Correção de YAW para igualar ao ATAN2
% yaw(yaw> pi) = yaw(yaw>pi)-2*pi ;
% yaw(yaw<-pi) = yaw(yaw<-pi)+2*pi;

%% Monta os vetores
Pose_real1   = [Px';Py';yaw'];      % Vetor de Posição
Velxyz_real  = [Vx';Vy';Vyaw'];     % Vetor de Velocidade BODY

%% ========= PARAMETROS DE ALOCAÇÃO DO VEÍCULO ==================
PoseNED_real = Pose_real1;
switch Nome
    case 'Cenario1'
        %% Rotação a posicao para plotar melhor
        for i=1:length(yaw)
            PoseNED_real(:,i) = BF2NED(-Ang,Pose_real1(:,i));
        end
    otherwise
        ini = ini /2;
        fim = fim /2;
end

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

PWM  = [pwm1' ;pwm2' ;pwm3' ;pwm4'];

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