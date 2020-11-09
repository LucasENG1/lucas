function PlotSPs(Time,SP)

for i=1:length(SP)
    
    figure(i)
    subplot(311)
    plot(Time,SP(i).F_Map(1,:));hold on;
    plot(Time,SP(i).F(1,:)); grid on; legend('Mapeado','Fx');
    
    subplot(312)
    plot(Time,SP(i).F_Map(2,:));hold on;
    plot(Time,SP(i).F(2,:)); grid on; legend('Mapeado','FY');
    
    subplot(313)
    plot(Time,SP(i).F_Map(3,:));hold on;
    plot(Time,SP(i).F(3,:)); grid on; legend('Mapeado','Tn');
    
    
    
end

end