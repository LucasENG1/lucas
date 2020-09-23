close all; clear all; clc;
%%
ParametrosBarco;  % Para plot das Figuras

global ROV Nmax Fmax;

Artigo1 = {'Cenario1','Cenario2','Cenario3','ComparaFinal3dof','ComparaFinal2dof'};
Idioma   = {'Portugues','Ingles'};
Language = Idioma{2};

Salva   = 0;  % 0/1 para salvar ou não as figuras obtidas

% for i = 1:length(Artigo1)
    
    SetPoint  = Artigo1{1};           % Nome do SP a ser carregado do LOG
    
    [Vel_real,Pose_real,Theta,PWM,F,F_out,Tempo,TempoAloc,TempoVel] = ReadLOG(SetPoint); % Leitura do LOG acontece aqui
    
    %% Concatena o nome para identificar as variaveis de teste real
%     SetPoint = strcat('Real_',SetPoint);
    
    save(strcat('Real/',strcat('Real_',SetPoint)),'ROV', 'Nmax', 'Fmax','Tempo','TempoAloc','TempoVel',...
        'Pose_real','Vel_real','Theta','PWM','F','F_out','SetPoint','Language')
    
% end

%% plot
PlotCenarioReal(Tempo,TempoAloc,TempoVel,Pose_real,Vel_real,Theta,PWM,F,F_out,SetPoint,Language,Salva);
















