function X = map(X,Y)
%% Fun��o que faz o mapeamento de um quadrado em um circulo para o controle do ve�culo por meio de joystick

X = X.*sqrt(1 - (Y.^2)/2);

end