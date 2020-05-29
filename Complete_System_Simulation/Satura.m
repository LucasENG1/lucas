function [value] = Satura(value, max, min)
 % Satura a variavel entre + saturation e -saturation
  value(value > max)  = max;
  value(value < min)  = min;

end