function A =  Mapeando(F)

maxF = max(abs(F));
F = F/maxF;

A(1) = mapcube(F(1),F(2),F(3));
A(2) = mapcube(F(2),F(1),F(3));
A(3) = mapcube(F(3),F(2),F(1));

A = A * maxF;
end