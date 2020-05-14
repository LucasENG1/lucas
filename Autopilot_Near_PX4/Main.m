clear all;
close all;
clc;
Initialisation
PhysicalProperties
global Sim SP

Sim.Vel=ones(3,1)*0.001;
Sim.Current_X_Y_psi = zeros(3,1);

sp = [10 10 10  -10 10 10   10;
      5  10 15  20 25  30   40 ];

SP.X = sp(1,:)/2;
SP.Y = sp(2,:);
t   = 0;
dt  = 0.1;
Xbf = 0;
Ybf = 0;
Yawbf =0;
plt = 1;
VAR = zeros(3,1);
stp = 1;
spx = SP.X(1);
spy = SP.Y(1);
xyp=zeros(3,1);
ayp=zeros(3,1);
TF=100;
while t < TF
    t(end+1) = t(end)+dt;
   
    AutoPilot2(stp)
    
    Xbf(end+1) = Xbf(end) + Sim.Vel(1,stp)*dt;
    Ybf(end+1) = Ybf(end) + Sim.Vel(2,stp)*dt;
    Yawbf(end+1) = Yawbf(end) + Sim.Vel(3,stp)*dt;    
    
    
    %%NED
    GT = BF2NED(Yawbf(end),[Xbf(end);Ybf(end);0]-[Xbf(end-1);Ybf(end-1);0]);   
    VAR(:,end+1) = VAR(:,end) + GT;
    VAR(:,end)= [VAR(1:2,end); Yawbf(end)];
    Sim.Current_X_Y_psi = VAR(:,end);
    
    if plt==1
        PlotBarco;
        hold on ; grid on;
        plot(SP.Y(1:stp),SP.X(1:stp),'or','markersize',10)
        plot(VAR(2,1:end),VAR(1,1:end),'b+');          % posição
        plot([VAR(2,end) SP.Y(stp)],[VAR(1,end) SP.X(stp)],'m','linewidth',2); % L1
        
        xyp(:,end+1) = BF2NED(Yawbf(end),[Sim.Vel(1,stp);0;0]);
        plot([VAR(2,end) VAR(2,end)+xyp(2,end)],[VAR(1,end) VAR(1,end)+xyp(1,end)],'b','linewidth',2);
        
        ayp(:,end+1) = BF2NED(Yawbf(end),[0;10*Sim.Vel(2,stp);0]);
        plot([VAR(2,end) VAR(2,end)+ayp(2,end)],[VAR(1,end) VAR(1,end)+ayp(1,end)],'g','linewidth',2);
        axis equal
        hold off;
        drawnow
    end
    spx(end+1) = SP.X(stp);
    spy(end+1) = SP.Y(stp);
    
    Err = norm([SP.X(stp);SP.Y(stp)]-VAR(1:2,end));   
    if(Err<1 && length(SP.X)>stp)
        stp = stp+1;
    end
        Sim.Vel(1,stp) = 0.4;

end

F     = 0*VAR;%F(:,1:passo:end)/5;
Theta = zeros(4,length(VAR(1,:)));
PWM   = zeros(4,length(VAR(1,:)));

% VV = VAR(3,1:length(spy)/length(SP.Y):end);
% for(x=2:length(VV))
%     xyp(:,x) = BF2NED(VV(1,x),[5*Sim.Vel(1,x-1);0;0]);
%     ayp(:,x) = BF2NED(VV(1,x),[0;10000*Sim.Vel(2,x-1);0]);
% end
figure; hold on ; grid on;

plot(SP.Y,SP.X,'--or','markersize',10,'linewidth',1.5)
plot(VAR(2,1:length(spy)/length(SP.Y):end),VAR(1,1:length(spy)/length(SP.Y):end),'-+','markersize',10,'linewidth',2);
plot([VAR(2,1:length(spy)/length(SP.Y):end); SP.Y],...
     [VAR(1,1:length(spy)/length(SP.Y):end); SP.X],'m','linewidth',2); % L1
 
PlotBarcoFigura([VAR(1,1:length(spy)/length(SP.Y):end);VAR(2,1:length(spy)/length(SP.Y):end);...
                 VAR(3,1:length(spy)/length(SP.Y):end)],Theta, PWM,F);
plot([VAR(2,1:length(spy)/length(SP.Y):end); VAR(2,1:length(spy)/length(SP.Y):end)+xyp(2,1:length(spy)/length(SP.Y):end)],...
     [VAR(1,1:length(spy)/length(SP.Y):end); VAR(1,1:length(spy)/length(SP.Y):end)+xyp(1,1:length(spy)/length(SP.Y):end)],'b','linewidth',2);
 
plot([VAR(2,1:length(spy)/length(SP.Y):end); VAR(2,1:length(spy)/length(SP.Y):end)+ayp(2,1:length(spy)/length(SP.Y):end)],...
     [VAR(1,1:length(spy)/length(SP.Y):end); VAR(1,1:length(spy)/length(SP.Y):end)+ayp(1,1:length(spy)/length(SP.Y):end)],'g','linewidth',2);

hold off;
drawnow
%%
figure;
ax1 = subplot(311);
plot(t,VAR(1,:),'r'); hold on; grid on
plot(t,spx,'b')
title('X');

ax2 = subplot(312);
plot(t,VAR(2,:),'r'); hold on; grid on
plot(t,spy,'b')
title('Y');

ax3 = subplot(313);
plot(t,VAR(3,:)*180/pi,'r'); hold on; grid on
% plot(t,spyaw,'b')
title('YAW');

