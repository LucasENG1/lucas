%% Comparação
close all; clear all; clc;

%% Carrega os Sps gerados em outro Arquivo
% Nesse caso identificou-se com com SPs senoidais o FCA teria uma
% "Vantagem" em relação aos demais (principalmente com cada sinal em
% frequencia diferente
load('../Cria_SPs/SetPoints100.mat');

%% Caracteristicas físicas da embarcação
global Pwmmax Pwmmin k1 Sim Fmax L Lx Ly Nmax ;

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

% Constante de Tempo para dinamica dos atuadores (Parametros do Murillo)
% settling_time_mt  = 0.3;
% settling_time_srv = 1.5;
%
Sim.Ts = Ts;
%
% APP.tau_mt  = settling_time_mt/5;    % Motors
% APP.tau_srv = settling_time_srv/5;   % Servos

%% Variavel de plot (0 ou 1)
Idioma   = {'Portugues','Ingles'};
Language = Idioma{2};

PlotarCenarios =0 ;
save = 0;

%%
Erro        = zeros(3,1);
ISE_FCA     = zeros(3,1);
ISE_FMIN1   = zeros(3,1);

for i=1:length(SP)  % O numero de SPs será o número de simulações ( Cada SP possui 3 sinais de N segundos)
    tic;
    Out_FCA(i).Th          = 0.001*[rand; rand; rand; rand];
    Out_FCA(i).PWM         = 0.001*[rand; rand; rand; rand];
    Out_FCA(i).F_out_FCA   = zeros(3,1);
    Out_FCA(i).Erro_FCA    = zeros(3,1);
    
    for j=1:length(SP(i).F_unitario_escalado(1,:))
        
        if j==1
            % Alocação
            [Out_FCA(i).Th(:,j),Out_FCA(i).PWM(:,j),Out_FCA(i).Erro_FCA(:,j),Out_FCA(i).F_out_FCA(:,j),Out_FCA(i).Time(j)] = Allocation_FCA(SP(i).F_unitario_escalado,Out_FCA(i).Th,Out_FCA(i).PWM,2);
        else
            % Alocação
            [Out_FCA(i).Th(:,j),Out_FCA(i).PWM(:,j),Out_FCA(i).Erro_FCA(:,j),Out_FCA(i).F_out_FCA(:,j),Out_FCA(i).Time(j)] = Allocation_FCA(SP(i).F_unitario_escalado,Out_FCA(i).Th,Out_FCA(i).PWM,j);
        end 
        % Erro Ponto a ponto
        Out_FCA(i).Erro_Saida_Final(:,j) = SP(i).F_unitario_escalado(:,j)- Out_FCA(i).F_out_FCA(:,j);
        
    end
    ISE_FCA(:,i) = (sum((Out_FCA(i).Erro_Saida_Final.^2)').*Sim.Ts)'; % ISE 
    Tempo_FCA(i) = toc;
end

%% ACTIVE SET
emax= 1e-6;
opt = optimoptions('fmincon','Algorithm','active-set','TolFun', emax, 'MaxIter', 10); % run active-set algorithm
opt.Display = 'notify';

for i=1:length(SP)
    tic
    Out_FMIN1(i).Th          = 0.001*[rand; rand; rand; rand];
    Out_FMIN1(i).PWM         = 0.001*[rand; rand; rand; rand];
    Out_FMIN1(i).F_out_FCA   = zeros(3,1);
    Out_FMIN1(i).Erro_FCA    = zeros(3,1);
    
    for j=1:length(SP(i).F_unitario_escalado(1,:))
        
        CTRL_IN  = SP(i).F_unitario_escalado(:,j);
        
        if j==1
            % Alocação
            [Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j),Out_FMIN1(i).Erro_FCA(:,j),Out_FMIN1(i).F_out(:,j),Out_FMIN1(i).Time(j)] = fmincon_use(SP(i).F_unitario_escalado(:,j),zeros(8,1),2,opt);
        else
            % Alocação
            [Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j),Out_FMIN1(i).Erro_FCA(:,j),Out_FMIN1(i).F_out(:,j),Out_FMIN1(i).Time(j)] = fmincon_use(SP(i).F_unitario_escalado(:,j),[Out_FMIN1(i).PWM;Out_FMIN1(i).Th],j,opt);
        end
        % Erro Ponto a ponto
        Out_FMIN1(i).Erro_Saida_Final(:,j) = SP(i).F_unitario_escalado(:,j)- Out_FMIN1(i).F_out(:,j);
    end
    
    ISE_FMIN1(:,i) = (sum((Out_FMIN1(i).Erro_Saida_Final.^2)').*Sim.Ts)'; % ISE
    Total_FMIN1(i) = toc;
end

%% INTERIOR-POINT
opt = optimoptions('fmincon','Algorithm','interior-point','TolFun', emax, 'MaxIter', 10); % run active-set algorithm
opt.Display = 'notify';

for i=1:length(SP)
    tic
    Out_FMIN2(i).Th          = 0.001*[rand; rand; rand; rand];
    Out_FMIN2(i).PWM         = 0.001*[rand; rand; rand; rand];
    Out_FMIN2(i).F_out_FCA   = zeros(3,1);
    Out_FMIN2(i).Erro_FCA    = zeros(3,1);
    
    for j=1:length(SP(i).F_unitario_escalado(1,:))
        
        CTRL_IN  = SP(i).F_unitario_escalado(:,j);
        
        if j==1
            % Alocação
            [Out_FMIN2(i).Th(:,j),Out_FMIN2(i).PWM(:,j),Out_FMIN2(i).Erro_FCA(:,j),Out_FMIN2(i).F_out(:,j),Out_FMIN2(i).Time(j)] = fmincon_use(SP(i).F_unitario_escalado(:,j),zeros(8,1),2,opt);
        else
            % Alocação
            [Out_FMIN2(i).Th(:,j),Out_FMIN2(i).PWM(:,j),Out_FMIN2(i).Erro_FCA(:,j),Out_FMIN2(i).F_out(:,j),Out_FMIN2(i).Time(j)] = fmincon_use(SP(i).F_unitario_escalado(:,j),[Out_FMIN2(i).PWM;Out_FMIN2(i).Th],j,opt);
        end
        % Erro Ponto a ponto
        Out_FMIN2(i).Erro_Saida_Final(:,j) = SP(i).F_unitario_escalado(:,j)- Out_FMIN2(i).F_out(:,j);
    end
    ISE_FMIN2(:,i) = (sum((Out_FMIN2(i).Erro_Saida_Final.^2)').*Sim.Ts)'; % ISE
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
        plot(Time,SP(i).F_unitario_escalado(1,:),'b',Img.Line{:}); hold on
        plot(Time,Out_FCA(i).F_Saida(1,:),'r',Img.Line{:});
        plot(Time,Out_FMIN1(i).F_Saida(1,:),'g',Img.Line{:});
        plot(Time,Out_FMIN2(i).F_Saida(1,:),'m',Img.Line{:});
        title('$F_x$',Img.TlabelOpt{:})
        legend('$SP$',Leg.Algorit{:},Img.Legend{:}); xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel{:},Img.YLabelOpt{:});
        grid on
        
        ax2 = subplot(312);
        plot(Time,SP(i).F_unitario_escalado(2,:),'b',Img.Line{:});hold on
        plot(Time,Out_FCA(i).F_Saida(2,:),'r',Img.Line{:});
        plot(Time,Out_FMIN1(i).F_Saida(2,:),'g',Img.Line{:});
        plot(Time,Out_FMIN2(i).F_Saida(2,:),'m',Img.Line{:});
        title('$F_y$',Img.TlabelOpt{:})
        legend('$SP$',Leg.Algorit{:},Img.Legend{:}) ; xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel{:},Img.YLabelOpt{:});
        grid on
        
        ax3 = subplot(313);
        plot(Time,SP(i).F_unitario_escalado(3,:),'b',Img.Line{:});hold on
        plot(Time,Out_FCA(i).F_Saida(3,:),'r',Img.Line{:});
        plot(Time,Out_FMIN1(i).F_Saida(3,:),'g',Img.Line{:});
        plot(Time,Out_FMIN2(i).F_Saida(3,:),'m',Img.Line{:});
        title('$\tau_{n}$',Img.TlabelOpt{:})
        legend('$SP$',Leg.Algorit{:},Img.Legend{:}) ; xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel2{:},Img.YLabelOpt{:});
        grid on
  
    end
end

i = 5;
%% PLOT BRABO
esq = 0.05;
dir = 0.875;
esp_vert_top = 0.02;
esp_bet_line = 0.004;
h            = 0.07;

axesVectors = [esq (1-h-esp_vert_top) dir h;...
    esq (1-2*h-esp_vert_top-2*esp_bet_line) dir h;...
    esq (1-3*h-esp_vert_top-4*esp_bet_line) dir h;...
    esq (1-4*h-esp_vert_top-6*esp_bet_line) dir h;...
    esq (1-5*h-esp_vert_top-8*esp_bet_line) dir h;...
    esq (1-6*h-esp_vert_top-10*esp_bet_line) dir h;...
    esq (1-7*h-esp_vert_top-12*esp_bet_line) dir h;...
    esq (1-8*h-esp_vert_top-14*esp_bet_line) dir h;...
    esq (1-9*h-esp_vert_top-16*esp_bet_line) dir h;...
    esq (1-10*h-esp_vert_top-18*esp_bet_line) dir h;...
    esq (1-11*h-esp_vert_top-20*esp_bet_line) dir h;...
    esq (1-12*h-esp_vert_top-22*esp_bet_line) dir h];

Fig2 = figure(Img.figOpt10L{:})

ax1 = axes('Position', axesVectors(1, :),Img.Par{:});
set(gcf,'Color','w');
plot(Time,SP(i).F_unitario_escalado(1,:),Img.SP{:}); hold on;
plot(Time,Out_FCA(i).F_out_FCA(1,:),Img.FCA{:});
plot(Time,Out_FMIN1(i).F_out(1,:),Img.FMIN1{:});
plot(Time,Out_FMIN2(i).F_out(1,:),Img.FMIN2{:});
ylabel(Leg.Fx{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on
legend(Leg.Algorit{:},Img.Legend{:},'Location', 'northoutside','Numcolumns',4)

ax2 = axes('Position', axesVectors(2, :),Img.Par{:});
plot(Time,SP(i).F_unitario_escalado(2,:),Img.SP{:}); hold on;
plot(Time,Out_FCA(i).F_out_FCA(2,:),Img.FCA{:});
plot(Time,Out_FMIN1(i).F_out(2,:),Img.FMIN1{:});
plot(Time,Out_FMIN2(i).F_out(2,:),Img.FMIN2{:});
ylabel(Leg.Fy{:},Img.YLabelOpt{:})
set(gca,'Box','off'); set(gca,'xticklabel',[]);grid on

ax3 = axes('Position', axesVectors(3, :),Img.Par{:});
plot(Time,SP(i).F_unitario_escalado(3,:),Img.SP{:}); hold on;
plot(Time,Out_FCA(i).F_out_FCA(3,:),Img.FCA{:});
plot(Time,Out_FMIN1(i).F_out(3,:),Img.FMIN1{:});
plot(Time,Out_FMIN2(i).F_out(3,:),Img.FMIN2{:});
ylabel(Leg.Tn{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

%%TH
ax4 = axes('Position', axesVectors(4, :),Img.Par{:});
plot(Time,Out_FCA(i).Th(1,:).*(180/pi),Img.FCA{:});hold on;
plot(Time,Out_FMIN1(i).Th(1,:).*(180/pi),Img.FMIN1{:});
plot(Time,Out_FMIN2(i).Th(1,:).*(180/pi),Img.FMIN2{:});
ylabel(Leg.Th1{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

ax5 = axes('Position', axesVectors(5, :),Img.Par{:});
plot(Time,Out_FCA(i).Th(2,:).*(180/pi),Img.FCA{:});hold on;
plot(Time,Out_FMIN1(i).Th(2,:).*(180/pi),Img.FMIN1{:});
plot(Time,Out_FMIN2(i).Th(2,:).*(180/pi),Img.FMIN2{:});
ylabel(Leg.Th2{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

ax6 = axes('Position', axesVectors(6, :),Img.Par{:});
plot(Time,Out_FCA(i).Th(3,:).*(180/pi),Img.FCA{:});hold on;
plot(Time,Out_FMIN1(i).Th(3,:).*(180/pi),Img.FMIN1{:});
plot(Time,Out_FMIN2(i).Th(3,:).*(180/pi),Img.FMIN2{:});
ylabel(Leg.Th3{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

ax7 = axes('Position', axesVectors(7, :),Img.Par{:});
plot(Time,Out_FCA(i).Th(4,:).*(180/pi),Img.FCA{:});hold on;
plot(Time,Out_FMIN1(i).Th(4,:).*(180/pi),Img.FMIN1{:});
plot(Time,Out_FMIN2(i).Th(4,:).*(180/pi),Img.FMIN2{:});
ylabel(Leg.Th4{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

%%PWM
ax8 = axes('Position', axesVectors(8, :),Img.Par{:});
plot(Time,k1.*Out_FCA(i).PWM(1,:),Img.FCA{:});hold on;
plot(Time,k1.*Out_FMIN1(i).PWM(1,:),Img.FMIN1{:});
plot(Time,k1.*Out_FMIN2(i).PWM(1,:),Img.FMIN2{:});
ylabel(Leg.PWM1{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

ax9 = axes('Position', axesVectors(9, :),Img.Par{:});
plot(Time,k1.*Out_FCA(i).PWM(2,:),Img.FCA{:});hold on;
plot(Time,k1.*Out_FMIN1(i).PWM(2,:),Img.FMIN1{:});
plot(Time,k1.*Out_FMIN2(i).PWM(2,:),Img.FMIN2{:});
ylabel(Leg.PWM2{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

ax10 = axes('Position', axesVectors(10, :),Img.Par{:});
plot(Time,k1.*Out_FCA(i).PWM(3,:),Img.FCA{:});hold on;
plot(Time,k1.*Out_FMIN1(i).PWM(3,:),Img.FMIN1{:});
plot(Time,k1.*Out_FMIN2(i).PWM(3,:),Img.FMIN2{:});
ylabel(Leg.PWM3{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

ax11 = axes('Position', axesVectors(11, :),Img.Par{:});
plot(Time,k1.*Out_FCA(i).PWM(4,:),Img.FCA{:});hold on;
plot(Time,k1.*Out_FMIN1(i).PWM(4,:),Img.FMIN1{:});
plot(Time,k1.*Out_FMIN2(i).PWM(4,:),Img.FMIN2{:});
ylabel(Leg.PWM4{:},Img.YLabelOpt{:})
set(gca,'Box','off');set(gca,'xticklabel',[]);grid on

ax12 = axes('Position', axesVectors(12, :),Img.Par{:});
plot(Time,Out_FCA(i).Time,Img.TFCA{:});hold on;
plot(Time,Out_FMIN1(i).Time,Img.TFMIN1{:});
plot(Time,Out_FMIN2(i).Time,Img.TFMIN2{:});
ylabel(Leg.PWM3{:},Img.YLabelOpt{:})


set(gca,'Box','off'); grid on
xlabel(Leg.Xlabel2{:},Img.YLabelOpt{:})
ylabel(Leg.Xlabel21{:},Img.YLabelOpt{:})

%%
Fig3 = figure(Img.figOpt4L{:})
ax1 = subplot(311);
val1 = [ISE_FCA(1,:);
    ISE_FMIN1(1,:);
    ISE_FMIN2(1,:)];
X = [1:length(val1(1,:))];

bar(X,val1');
title('$F_x$',Img.TlabelOpt{:})
legend(Leg.Algorit{2:end},Img.Legend{:}); title(Leg.Title1{:},Img.TlabelOpt{:}); xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
grid on

ax2 = subplot(312);
val2= [ISE_FCA(2,:);
    ISE_FMIN1(2,:);
    ISE_FMIN2(2,:)];
X = [1:length(val2(1,:))];

bar(X,val2');
title('$F_y$',Img.TlabelOpt{:})
legend(Leg.Algorit{2:end},Img.Legend{:}); title(Leg.Title2{:},Img.TlabelOpt{:}); xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
grid on

ax3 = subplot(313);
val3 = [ISE_FCA(3,:);
    ISE_FMIN1(3,:);
    ISE_FMIN2(3,:)];
X = [1:length(val3(1,:))];

bar(X,val3');
title('$\tau_{n}$',Img.TlabelOpt{:})
legend(Leg.Algorit{2:end},Img.Legend{:}); title(Leg.Title3{:},Img.TlabelOpt{:}); xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
grid on

linkaxes([ax1 ax2 ax3],'x')

disp('=========================== FCA =========================== ')

Fca_tmed = sum(Tempo_FCA)/length(Tempo_FCA);
disp(strcat('Tempo Medio : ',string(Fca_tmed)))

Fca_tmax = max(Tempo_FCA);
disp(strcat('Tempo Maximo : ',string(Fca_tmax)))

Fca_tmin = min(Tempo_FCA);
disp(strcat('Tempo Minimo : ',string(Fca_tmin)))
%ISE
Fca_ise_mean = norm(sum(ISE_FCA')./length(ISE_FCA));
disp('ISE Medio : ')
disp(Fca_ise_mean)

Fca_ise_max = norm(max(ISE_FCA'));
disp('ISE Maximo : ')
disp(Fca_ise_max)

Fca_ise_min = norm(min(ISE_FCA'));
disp('ISE Minimo : ')
disp(Fca_ise_min)

disp('=========================== Active-Set =========================== ')

Fmin1_tmed = sum(Total_FMIN1)/length(Total_FMIN1);
disp(strcat('Tempo Medio : ',string(Fmin1_tmed)))

Fmin1_tmax = max(Total_FMIN1);
disp(strcat('Tempo Maximo : ',string(Fmin1_tmax)))

Fmin1_tmin = min(Total_FMIN1);
disp(strcat('Tempo Minimo : ',string(Fmin1_tmin)))

%ISE
Fmin1_ise_mean = norm(sum(ISE_FMIN1')./length(ISE_FMIN1));
disp('ISE Medio : ')
disp(Fmin1_ise_mean)

Fmin1_ise_max = norm(max(ISE_FMIN1'));
disp('ISE Maximo : ')
disp(Fmin1_ise_max)

Fmin1_ise_min = norm(min(ISE_FMIN1'));
disp('ISE Minimo : ')
disp(Fmin1_ise_min)

disp('========================== Interior-Point =========================== ')

Fmin2_tmed = sum(Total_FMIN2)/length(Total_FMIN2);
disp(strcat('Tempo Medio : ',string(Fmin2_tmed)))

Fmin2_tmax = max(Total_FMIN2);
disp(strcat('Tempo Maximo : ',string(Fmin2_tmax)))

Fmin2_tmin = min(Total_FMIN2);
disp(strcat('Tempo Minimo : ',string(Fmin2_tmin)))

%ISE
Fmin2_ise_mean = norm(sum(ISE_FMIN2')./length(ISE_FMIN2));
disp('ISE Medio : ')
disp(Fmin2_ise_mean)

Fmin2_ise_max = norm(max(ISE_FMIN2'));
disp('ISE Maximo : ')
disp(Fmin2_ise_max)

Fmin2_ise_min = norm(min(ISE_FMIN2'));
disp('ISE Minimo : ')
disp(Fmin2_ise_min)

% display('FMINCON ACTIVE-SET')
% Total_FMIN1
% MeanISE_FMIN1 = sum(ISE_FMIN1')./length(ISE_FMIN1)
% 
% display('FMINCON INTERIOR-POINT')
% Total_FMIN2
% MeanISE_FMIN2 = sum(ISE_FMIN2')./length(ISE_FMIN2)

if save
    saveas(Fig2,'Example_SP','epsc');
    saveas(Fig2,'Example_SP','fig');
    
    saveas(Fig,'ISE_Error','epsc');
    saveas(Fig,'ISE_Error','fig');
    
end

saveas(Fig2,'banch_Final','epsc');

saveas(Fig2,'banch_Final','png');
saveas(Fig2,'banch_Final','fig');