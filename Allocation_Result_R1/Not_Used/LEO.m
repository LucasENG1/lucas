function X = LEO(SP,VLR,dt) %INTEGRAl DO VALOR ABSOLUTO DO ERRO
    
% Acumulador = acum + abs(erro)*dx;
Erro = abs((SP - VLR).*dt);

X = abs(sum(Erro))/length(Erro);

Y = abs(sum(SP.*dt))/length(Erro);

X = X/Y;

end