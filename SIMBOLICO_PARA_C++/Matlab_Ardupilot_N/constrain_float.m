function FX = constrain_float(FX,min,max)

FX(FX>max) = max;
FX(FX<min) = min;