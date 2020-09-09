close all; clear all; clc;
%%
ParametrosBarco;  % Para plot das Figuras

Artigo1 = {'Cenario1','Cenario2','Cenario3','ComparaFinal3dof','ComparaFinal2dof'};
Idioma   = {'Portugues','Ingles'};

Nome_SP  = Artigo1{4};           % Nome do SP a ser carregado do LOG
Language = Idioma{2};

Salva   = 1;                     % 0/1 para salvar ou n�o as figuras obtidas

[Vel_real,Pose_real,Theta,PWM,F,F_out,Tempo,TempoAloc,TempoVel] = ReadLOG(Nome_SP); % Leitura do LOG acontece aqui

%% Concatena o nome para identificar as variaveis de teste real
Nome_SP = strcat(Nome_SP,'_Real');

%% plot
PlotCenarioReal(Tempo,TempoAloc,TempoVel,Pose_real,Vel_real,Theta,PWM,F,F_out,Nome_SP,Language,Salva);
















