function X = mapcube(X,Y,Z)
%% A primeira variável será mapeada

X = X.*sqrt(1 - (Y.^2)/2 - (Z.^2)/2 + (Y.^2*Z.^2)/3);

end