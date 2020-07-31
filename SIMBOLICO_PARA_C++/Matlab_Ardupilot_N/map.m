function X = map(X,Y)

%     /// Função para mapeamento da entrada do controle quadrada para circulo
    X =  X*(sqrt(1-sq(Y)/2));
end
