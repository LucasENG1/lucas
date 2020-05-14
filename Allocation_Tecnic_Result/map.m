function X = map(X,Y)
%% Função que faz o mapeamento de um quadrado em um circulo para o controle do veículo por meio de joystick

X = X.*sqrt(1 - (Y.^2)/2);

end