function X = MAE(SP,VLR,dt) %INTEGRAl DO VALOR ABSOLUTO DO ERRO
    
% Acumulador = acum + abs(erro)*dx;
Erro = (SP - VLR).*dt;

X = sum(Erro)/length(Erro);

end