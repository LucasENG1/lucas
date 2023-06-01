% Ajusta Ângulos do intevalo [0,2*pi] para o intervalo [-pi,pi]

function angulo = AjustaAngulo(angulo)

angulo = mod(angulo, 2*pi);
if angulo>pi
    angulo = angulo -2*pi;
end

end
