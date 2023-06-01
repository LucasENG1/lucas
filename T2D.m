% M1 é o(a) vetor/matriz (coluna) no frame original
% M2 é o(a) vetor/matriz (coluna) M1 transladado(a)
% DeltaX é a quantidade a ser transladada no eixo-x (original)
% DeltaY é a quantidade a ser transladada no eixo-y (original)

function M2 = T2D(M1, DeltaX, DeltaY)

% Matriz de translação bidimensional (2D)
T = [1 0 DeltaX
     0 1 DeltaY
     0 0 1];
 
% Aplicando a translação
M2 = T * M1;

end