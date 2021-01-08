close all; clear all; clc;

L   = 0.586;
Fmax = 2.1*9.81*4; % Força maxíma real
Fmax = Fmax/5;
Nmax = L*Fmax;

Ts = 0.1;
Time = 0:Ts:20;
N_sim = 100;

%% Gera um sinal aleatorio [Fx ;Fy;Tn]
% IMPORTANTE: O sinal deve estar entre -1 a 1 devido ao mapeamento para
% zona de factibilidade
for i=1:N_sim
    SP(i).F_unitario = [ rand.*sin(2*pi*0.1.*Time);...
        rand.*cos(2*pi*0.2.*Time);...
        rand.*ones(1,length(Time))];
end

% Mapeamento de Cada sinal para factibilidade e escala para Newton
for j=1:length(SP)
    % Escala
    A = Fmax;
    B = Fmax;
    C = Nmax;
    
    for i=1:length(SP(j).F_unitario(1,:))
        % Mapeamento e Escala dos sinais
        F_Map(1,i) = A*mapcube(SP(j).F_unitario(1,i),SP(j).F_unitario(2,i),SP(j).F_unitario(3,i));
        F_Map(2,i) = B*mapcube(SP(j).F_unitario(2,i),SP(j).F_unitario(1,i),SP(j).F_unitario(3,i));
        F_Map(3,i) = C*mapcube(SP(j).F_unitario(3,i),SP(j).F_unitario(2,i),SP(j).F_unitario(1,i));
    end
    
    SP(j).F_Mapeado = F_Map;
    
    SP(j).F_unitario_escalado = [A.*SP(j).F_unitario(1,:);...
                                 B.*SP(j).F_unitario(2,:);...
                                 C.*SP(j).F_unitario(3,:)];
end

save('SetPoints.mat','SP','Time','Ts');

