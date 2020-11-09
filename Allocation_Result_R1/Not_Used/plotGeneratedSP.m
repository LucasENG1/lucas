function plotGeneratedSP(Tempo, SP_Fx, SP_Fy,SP_Tn,Nsim,cor)
for i=1:Nsim
    figure(i)
    subplot(311); hold on;
    plot(Tempo,SP_Fx(i,:),cor)
    
    subplot(312); hold on;
    plot(Tempo,SP_Fy(i,:),cor)
    
    subplot(313); hold on;
    plot(Tempo,SP_Tn(i,:),cor)
end

end