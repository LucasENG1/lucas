function [] = FiguraArtigo(Nboats,XYZ)

% global Sim  SimOutput_Plot SP ;

% Nboats = 12;

passo = floor(length(XYZ(1,:))/Nboats);
XYpsi = [XYZ(:,1:passo:end)];
yaw   = XYpsi(end,:);
F     = 0*XYpsi;%F(:,1:passo:end)/5;
Theta = zeros(4,length(XYpsi(1,:)));
PWM   = zeros(4,length(XYpsi(1,:)));

% figure
% plot(SP.Y,SP.X,'b');
% hold on
% plot(SimOutput_Plot.X_Y_psi(2,:),SimOutput_Plot.X_Y_psi(1,:),'g');
PlotBarcoFigura(yaw,XYpsi,Theta,PWM,F);





end