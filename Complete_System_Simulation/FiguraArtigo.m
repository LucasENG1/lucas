function [] = FiguraArtigo(Nboats,XYZ)
%% plota o numero de barcos pedido bem como as curvas 

passo = floor(length(XYZ(1,:))/Nboats);
XYpsi = [XYZ(:,1:passo:end)];
yaw   = XYpsi(end,:);
F     = 0*XYpsi;%F(:,1:passo:end)/5;
Theta = zeros(4,length(XYpsi(1,:)));
PWM   = zeros(4,length(XYpsi(1,:)));

% Ajuste necessário
aux= XYpsi;
XYpsi(1,:) = aux(2,:);
XYpsi(2,:) = aux(1,:);

PlotBarcoFigura(yaw,XYpsi,Theta, PWM,F);




end