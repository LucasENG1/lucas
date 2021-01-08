function X = IAE(SP,VLR,dt) %INTEGRAl DO VALOR ABSOLUTO DO ERRO
    
% Acumulador = acum + abs(erro)*dx;
X = sum((SP - VLR))*dt;

end