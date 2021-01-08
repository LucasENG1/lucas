function plotGeneratedSP(Tempo, SP,cor,ax)
for i=1:length(SP)
    
    switch ax
        case 1
            figure(i)
            subplot(311); hold on;
            plot(Tempo,SP(i).F_unitario(1,:),cor)
            
            subplot(312); hold on;
            plot(Tempo,SP(i).F_unitario(2,:),cor)
            
            subplot(313); hold on;
            plot(Tempo,SP(i).F_unitario(3,:),cor)
        case 2
            figure(i)
            subplot(311); hold on;
            plot(Tempo,SP(i).F_unitario_escalado(1,:),cor)
            
            subplot(312); hold on;
            plot(Tempo,SP(i).F_unitario_escalado(2,:),cor)
            
            subplot(313); hold on;
            plot(Tempo,SP(i).F_unitario_escalado(3,:),cor)
            
        case 3
            figure(i)
            subplot(311); hold on;
            plot(Tempo,SP(i).F_Mapeado(1,:),cor)
            
            subplot(312); hold on;
            plot(Tempo,SP(i).F_Mapeado(2,:),cor)
            
            subplot(313); hold on;
            plot(Tempo,SP(i).F_Mapeado(3,:),cor)
    end
    
end