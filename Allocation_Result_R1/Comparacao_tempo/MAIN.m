%% Comparação
close all; clear all; clc;

%% Caracteristicas físicas da embarcação
global Pwmmax Pwmmin APP k1 Sim Fmax L Lx Ly Nmax ;
L   = 0.586;
Fmax = 2.1*9.81*4; % Força maxíma real
Nmax   = L*Fmax;
Pwmmax = 1000.0;
Pwmmin = 0.0;
% Braços de alavanca do Motor
Lx = L*cos(pi/4.0);
Ly = L*cos(pi/4.0);
% Constante de propulsão do motor
k1 =(Fmax/4.0)/(Pwmmax-Pwmmin);
Sim.Ts = 0.01;
% Constante de Tempo para dinamica dos atuadores (Parametros do Murillo)
% settling_time_mt  = 0.3;
% settling_time_srv = 1.5;

% APP.tau_mt  = settling_time_mt/5;    % Motors
% APP.tau_srv = settling_time_srv/5;   % Servos


%% Carrega os Sps gerados em outro Arquivo
SP(1).F_unitario_escalado = [-3;-2;5];
Time = 1;


%% Variavel de plot (0 ou 1)
Idioma   = {'Portugues','Ingles'};
Language = Idioma{2};

PlotarCenarios =1 ;
save = 0;

%%
Erro        = zeros(3,1);
ISE_FCA     = zeros(3,1);
ISE_FMIN1   = zeros(3,1);

for i=1:length(SP)  % O numero de SPs será o número de simulações ( Cada SP possui 3 sinais de N segundos)
    tic;
    Out_FCA(i).Th          = [atan2(-2,-2); atan2(-2,-2); atan2(-2,-2); atan2(-2,-2)];
    Out_FCA(i).PWM         = [10/4; 10/4; 10/4; 10/4];
    Out_FCA(i).F_out_FCA   = zeros(3,1);
    Out_FCA(i).Erro_FCA    = zeros(3,1);
    
    j = 1;
    [Out_FCA(i).Th(:,j),Out_FCA(i).PWM(:,j),Out_FCA(i).Erro_FCA(:,j),Erro_int(i),Out_FCA(i).F_out_FCA(:,j)] = Allocation_FCA(SP(i).F_unitario_escalado,Out_FCA(i).Th,Out_FCA(i).PWM,2);
    % Servor Dynamics
    %         [Out(i).Th(:,j),Out(i).PWM(:,j)] = DynamicsOfServosAndMotors(j,Out(i).Th,Out(i).PWM);
    
    % Alocação Direta depois da dinamica dos atuadores
    Out_FCA(i).F_Saida(:,j) = Aloc_Direta(Out_FCA(i).Th(:,j),Out_FCA(i).PWM(:,j));
    % Erro Ponto a ponto
    Out_FCA(i).Erro_Saida_Final(:,j) = SP(i).F_unitario_escalado(:,j)- Out_FCA(i).F_Saida(:,j);
    
    ISE_FCA(:,i) = (Out_FCA(i).Erro_Saida_Final.^2).*Sim.Ts; % ISE (Utilizdo no paper do Murillo)
    
Tempo_FCA(i) = toc;
end

%% ACTIVE SET
emax= 1e-6;
opt = optimoptions('fmincon','Algorithm','active-set','TolFun', emax, 'MaxIter', 2); % run active-set algorithm
opt.Display = 'notify';

for i=1:length(SP)
    tic
    Out_FMIN1(i).Th          = 0.001.*[rand; rand; rand; rand];
    Out_FMIN1(i).PWM         = 0.0001.*[rand; rand; rand; rand];
    Out_FMIN1(i).F_out_FCA   = zeros(3,1);
    Out_FMIN1(i).Erro_FCA    = zeros(3,1);
    
    j=1;
    
    [Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j),Out_FMIN1(i).Erro_FCA(:,j),Erro_Fmin1] = fmincon_use(SP(i).F_unitario_escalado(:,j),[Out_FMIN1(i).PWM;Out_FMIN1(i).Th],2,opt);
    
    %         % Servor Dynamics
    %         [Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j)] = DynamicsOfServosAndMotors(j,Out_FMIN1(i).Th,Out_FMIN1(i).PWM);
    % Alocação Direta depois da dinamica dos atuadores
    Out_FMIN1(i).F_Saida(:,j) = Aloc_Direta(Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j));
    % Erro Ponto a ponto
    Out_FMIN1(i).Erro_Saida_Final(:,j) = SP(i).F_unitario_escalado(:,j)- Out_FMIN1(i).F_Saida(:,j);
    
    ISE_FMIN1(:,i) = (Out_FMIN1(i).Erro_Saida_Final.^2).*Sim.Ts; % ISE (Utilizdo no paper do Murillo)
Total_FMIN1(i) = toc;
end


%% INTERIOR-POINT
opt = optimoptions('fmincon','Algorithm','interior-point','TolFun', emax, 'MaxIter', 2); % run active-set algorithm
opt.Display = 'notify';

for i=1:length(SP)
    tic
    Out_FMIN2(i).Th          = 0.001.*[rand; rand; rand; rand];
    Out_FMIN2(i).PWM         = 0.0001.*[rand; rand; rand; rand];
    Out_FMIN2(i).F_out_FCA   = zeros(3,1);
    Out_FMIN2(i).Erro_FCA    = zeros(3,1);
    
    j=1;
    
    % Alocação
    [Out_FMIN2(i).Th(:,j),Out_FMIN2(i).PWM(:,j),Out_FMIN2(i).Erro_FCA(:,j),Erro_Fmin2] = fmincon_use(SP(i).F_unitario_escalado(:,j),[Out_FMIN2(i).PWM;Out_FMIN2(i).Th],2,opt);
    
    %         % Servor Dynamics
    %         [Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j)] = DynamicsOfServosAndMotors(j,Out_FMIN1(i).Th,Out_FMIN1(i).PWM);
    % Alocação Direta depois da dinamica dos atuadores
    Out_FMIN2(i).F_Saida(:,j) = Aloc_Direta(Out_FMIN2(i).Th(:,j),Out_FMIN2(i).PWM(:,j));
    % Erro Ponto a ponto
    Out_FMIN2(i).Erro_Saida_Final(:,j) = SP(i).F_unitario_escalado(:,j)- Out_FMIN2(i).F_Saida(:,j);
    
    ISE_FMIN2(:,i) = ((Out_FMIN2(i).Erro_Saida_Final.^2)').*Sim.Ts; % ISE (Utilizdo no paper do Murillo)
Total_FMIN2(i) = toc;
end



%% Figuras
Img = ImageParametrization();
Leg = LegendLanguage(Language);

if PlotarCenarios
    for i=1:length(SP)
        %% Força de saida
        Fig = figure(Img.figOpt4L{:})
        ax1 = subplot(311);
        plot(Time,SP(i).F_unitario_escalado(1,:),'xb',Img.Line{:}); hold on
        plot(Time,Out_FCA(i).F_Saida(1,:),'or',Img.Line{:});
        plot(Time,Out_FMIN1(i).F_Saida(1,:),'vg',Img.Line{:});
        plot(Time,Out_FMIN2(i).F_Saida(1,:),'sm',Img.Line{:});
        title('$F_x$',Img.TlabelOpt{:})
        legend('$SP$',Leg.Algorit{:},Img.Legend{:}); xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel{:},Img.YLabelOpt{:});
        grid on
        
        ax2 = subplot(312);
        plot(Time,SP(i).F_unitario_escalado(2,:),'xb',Img.Line{:});hold on
        plot(Time,Out_FCA(i).F_Saida(2,:),'or',Img.Line{:});
        plot(Time,Out_FMIN1(i).F_Saida(2,:),'vg',Img.Line{:});
        plot(Time,Out_FMIN2(i).F_Saida(2,:),'sm',Img.Line{:});
        title('$F_y$',Img.TlabelOpt{:})
        legend('$SP$',Leg.Algorit{:},Img.Legend{:}) ; xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel{:},Img.YLabelOpt{:});
        grid on
        
        ax3 = subplot(313);
        plot(Time,SP(i).F_unitario_escalado(3,:),'xb',Img.Line{:});hold on
        plot(Time,Out_FCA(i).F_Saida(3,:),'or',Img.Line{:});
        plot(Time,Out_FMIN1(i).F_Saida(3,:),'vg',Img.Line{:});
        plot(Time,Out_FMIN2(i).F_Saida(3,:),'sm',Img.Line{:});
        title('$\tau_{n}$',Img.TlabelOpt{:})
        legend('$SP$',Leg.Algorit{:},Img.Legend{:}) ; xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel2{:},Img.YLabelOpt{:});
        grid on
        
        %%
        Fig = figure(Img.figOpt4L{:})
        ax1 = subplot(311);
        val1 = [ISE_FCA(1,:);
            ISE_FMIN1(1,:);
            ISE_FMIN2(1,:)];
        X = categorical({'FCA','Active-set','Interior-point'});
        X = reordercats(X,{'FCA','Active-set','Interior-point'});
        bar(X,val1);
        
        title('$F_x$',Img.TlabelOpt{:})
%         legend(Leg.Algorit{:},Img.Legend{:});
        title(Leg.Title1{:},Img.TlabelOpt{:});
        xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
        grid on
        
        ax2 = subplot(312);
        val2= [ISE_FCA(2,:);
            ISE_FMIN1(2,:);
            ISE_FMIN2(2,:)];
                
        bar(X,val2);
        
        title('$F_y$',Img.TlabelOpt{:})
%         legend(Leg.Algorit{:},Img.Legend{:}); 
        title(Leg.Title2{:},Img.TlabelOpt{:});
        xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
        grid on
        
        ax3 = subplot(313);
        val3 = [ISE_FCA(3,:);
            ISE_FMIN1(3,:);
            ISE_FMIN2(3,:)];
        
        bar(X,val3);
        
        title('$\tau_{n}$',Img.TlabelOpt{:})
%         legend(Leg.Algorit{:},Img.Legend{:});
        title(Leg.Title3{:},Img.TlabelOpt{:});
        xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
        grid on
        
    end
end

f=figure(Img.figOpt2L{:})
plot([0.5:.5:15],Erro_int.E1,'-ob','linewidth',2,'markersize',5); hold on
plot([1:1:15],Erro_Fmin1,'-xr','linewidth',2,'markersize',5);
plot([1:1:15],Erro_Fmin2,'-vm','linewidth',2,'markersize',5);
xlabel('Iteration[i]')
legend('FCA','Active-set', 'Interior-point');
grid on

display('FCA Output')
Tempo_FCA
MeanISE_FCA   = sum(ISE_FCA')./length(ISE_FCA)

display('FMINCON ACTIVE-SET')
Total_FMIN1
MeanISE_FMIN1 = sum(ISE_FMIN1')./length(ISE_FMIN1)

display('FMINCON INTERIOR-POINT')
Total_FMIN2
MeanISE_FMIN2 = sum(ISE_FMIN2')./length(ISE_FMIN2)

if save
    saveas(FigSPs,'Example_SP','epsc');
    saveas(FigSPs,'Example_SP','fig');
    
    saveas(Fig,'ISE_Error','epsc');
    saveas(Fig,'ISE_Error','fig');
    
end

Out_FCA.Th*180/pi
Out_FCA.PWM
