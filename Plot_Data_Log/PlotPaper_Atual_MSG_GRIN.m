% Inicialização limpando as varáveis THIS IS THE MAIN
close all; clear all; clc;
%%
ParametrosBarco()  % Para plot das Figuras

Artigo1 = {'Linear','Circular','SquareROI','Square1_top','Square_dif'};

Nome_SP = Artigo1{4};           % Nome do SP a ser carregado do LOG
Salva   = 0;                  % 0/1 para salvar ou não as figuras obtidas

Idioma   = {'Portugues','Ingles'};
Language = Idioma{2};

[Vel_real,Pose_real,Theta,PWM,F,F_out,Tempo,TempoAloc,TempoVel] = ReadLOG(Nome_SP); % Leitura do LOG acontece aqui

%% Creates SetPoints to Be compared
% SetPointsCreation(Nome_SP,Pose_real);

%% Concatena o nome para identificar as variaveis de teste real
Nome_SP = strcat(Nome_SP,'_Real');

%%
PlotCenarioReal(Tempo,TempoAloc,TempoVel,Pose_real,Vel_real,Theta,PWM,F,F_out,Nome_SP,Language,Salva);

% global SP;
% ise1 = ISE(sqrt(Pose_real(1,:).^2+Pose_real(2,:).^2),TempoVeiculo,sqrt(SP.X.^2+SP.Y.^2),SP.t)














