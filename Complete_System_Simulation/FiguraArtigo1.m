function [] = FiguraArtigo1(Nboats)
%% Plota a parte simulada do Sistema
global   SimOutput_Plot SP ;

%% FIGURA POSIÇÃO COM BARCO
passo = floor(length(SimOutput_Plot.X_Y_psi(1,:))/Nboats);
XYpsi = [SimOutput_Plot.X_Y_psi(:,1:passo:end)];
yaw   = XYpsi(end,:);

F     = 0*XYpsi;%F(:,1:passo:end)/5;
Theta = zeros(4,length(XYpsi(1,:)));
PWM   = zeros(4,length(XYpsi(1,:)));

%% Utilizar essa se quiser ver os angulos e PWMs no plot
% F     = Sim.F(:,1:passo:end)/5;
% Theta = Sim.Theta(:,2:passo:end);
% PWM   = Sim.PWM(:,2:passo:end);

figure
plot(SP.Y,SP.X,'b');
hold on
plot(SimOutput_Plot.X_Y_psi(2,:),SimOutput_Plot.X_Y_psi(1,:),'r');
PlotBarcoFigura(XYpsi,Theta, PWM,F);



end