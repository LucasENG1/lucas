function X = MSE(SP,VLR,dt) %INTEGRAl DO VALOR ABSOLUTO DO ERRO
    
% Acumulador = acum + abs(erro)*dx;
Erro = ((SP - VLR).*dt).^2;

X = sum(Erro)/length(Erro);

end