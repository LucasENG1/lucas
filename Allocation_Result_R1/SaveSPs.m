close all; clear all; clc;

L   = 0.586;
Fmax = 2.1*9.81*4; % Força maxíma real
Nmax = L*Fmax;

Ts = 0.01;
Time = 0:Ts:15;

for i=1:10
    SP(i).F1 = [ rand.*sin(2*pi*0.1.*Time);...
            rand.*cos(2*pi*0.2.*Time);...
            rand.*ones(1,length(Time))];
end

for j=1:length(SP)
            A = Fmax;
            B = Fmax;
            C = Nmax;
            
    for i=1:length(SP(j).F1(1,:))
        F_Mapeado(1,i) = A*mapcube(SP(j).F1(1,i),SP(j).F1(2,i),SP(j).F1(3,i));
        F_Mapeado(2,i) = B*mapcube(SP(j).F1(2,i),SP(j).F1(1,i),SP(j).F1(3,i));
        F_Mapeado(3,i) = C*mapcube(SP(j).F1(3,i),SP(j).F1(2,i),SP(j).F1(1,i));
    end
   SP(j).F_Map = F_Mapeado;
   SP(j).F = [A.*SP(j).F1(1,:);...
              B.*SP(j).F1(2,:);...
              C.*SP(j).F1(3,:)];
end

save('SetPoints.mat','SP','Time');

