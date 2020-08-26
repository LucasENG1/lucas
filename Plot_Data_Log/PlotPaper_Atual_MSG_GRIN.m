% Inicialização limpando as varáveis THIS IS THE MAIN
close all; clear all; clc;
%%
ParametrosBarco()

Nome = {'Circular','LinearX','Sway','Sway2','Oito','OUTRO'};

Nome2 = {'survey_1', 'survey_1_Diferencial','Square1_top','Square2_top',...
        'Square_3', 'Square_dif','Square2_dif' ,'Star','Star_dif'};

Language = {'Portugues','Ingles'};
Lang     = Language{2};

Nome_SP = Nome2{3};           % Nome do SP a ser carregado do LOG
salva = 0;                    % 0/1 para salvar ou não as figuras obtidas

[Vel_real,Pose_real,TempoVeiculo,Theta,PWM,F,F_out,TempoAlocacao] = ReadLOG(Nome_SP); % Leitura do LOG acontece aqui

%% Creates SetPoints to Be compared
SetPointsCreation(Nome_SP,Pose_real);

%% Concatena o nome para identificar as variaveis de teste real
Nome_SP = strcat(Nome_SP,'_Real');

%%
PlotCenarioReal(TempoVeiculo,TempoAlocacao,Pose_real,Vel_real,Nome_SP,Lang,salva);

%%
PlotSaidaReal(TempoAlocacao,Theta,PWM,F,F_out,Nome_SP,Lang,salva);














