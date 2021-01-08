close all; clc; clear all;

Cenario =  {'Cenario1','Cenario2','Cenario3','ComparaFinal3dof','ComparaFinal2dof'};
Salvar = 1;

Idioma   = {'Portugues','Ingles'};
Language = Idioma{1};

Nboats = 10;
% plota todos os Simulados
for i=1:3
    load(strcat('Simulado_LOG/',strcat('Sim_',Cenario{i})));
    
    PlotCenarioSimulado(Nboats,SetPoint,Language,Salvar);
end
% clear all
% close all
for i = 1: length(Cenario)
    load(strcat('Real_LOG/',strcat('Real_',Cenario{i})));
    Language = Idioma{1};
    PlotCenarioReal(Nboats,Tempo,TempoAloc,TempoVel,Pose_real,Vel_real,Theta,PWM,F,F_out,SetPoint,Language,Salvar);
end