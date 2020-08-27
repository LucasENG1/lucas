function ISE = ISE(Sinal,Tsinal,Referencia,Treferencia)

for i=1: length(Treferencia)
    aux = abs(Tsinal - Treferencia(i));
    [v,Tou(i)] = min(aux);
end

VET = Sinal(Tou);

ISE = sum((Referencia-VET).^2);
end
    