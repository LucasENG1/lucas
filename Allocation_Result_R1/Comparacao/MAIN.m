%% Comparação
close all; clear all; clc;

%% Carrega os Sps gerados em outro Arquivo
% Nesse caso identificou-se com com SPs senoidais o FCA teria uma
% "Vantagem" em relação aos demais (principalmente com cada sinal em
% frequencia diferente
load('../Cria_SPs/SetPoints10.mat');

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
save = 1;

%%
Erro        = zeros(3,1);
ISE_FCA     = zeros(3,1);
ISE_FMIN1   = zeros(3,1);

tic;
for i=1:length(SP)  % O numero de SPs será o número de simulações ( Cada SP possui 3 sinais de N segundos)
    
    Out_FCA(i).Th          = [rand; rand; rand; rand];
    Out_FCA(i).PWM         = [rand; rand; rand; rand];
    Out_FCA(i).F_out_FCA   = zeros(3,1);
    Out_FCA(i).Erro_FCA    = zeros(3,1);
    
    for j=1:length(SP(i).F_unitario_escalado(1,:))
        
        if j==1
            % Alocação
            [Out_FCA(i).Th(:,j),Out_FCA(i).PWM(:,j),Out_FCA(i).Erro_FCA(:,j),Out_FCA(i).F_out_FCA(:,j)] = Allocation_FCA(SP(i).F_unitario_escalado,Out_FCA(i).Th,Out_FCA(i).PWM,2);
        else
            % Alocação
            [Out_FCA(i).Th(:,j),Out_FCA(i).PWM(:,j),Out_FCA(i).Erro_FCA(:,j),Out_FCA(i).F_out_FCA(:,j)] = Allocation_FCA(SP(i).F_unitario_escalado,Out_FCA(i).Th,Out_FCA(i).PWM,j);
        end
        
        % Servor Dynamics
        %         [Out(i).Th(:,j),Out(i).PWM(:,j)] = DynamicsOfServosAndMotors(j,Out(i).Th,Out(i).PWM);
        
        % Alocação Direta depois da dinamica dos atuadores
        Out_FCA(i).F_Saida(:,j) = Aloc_Direta(Out_FCA(i).Th(:,j),Out_FCA(i).PWM(:,j));
        % Erro Ponto a ponto
        Out_FCA(i).Erro_Saida_Final(:,j) = SP(i).F_unitario_escalado(:,j)- Out_FCA(i).F_Saida(:,j);
        
    end
    ISE_FCA(:,i) = (sum((Out_FCA(i).Erro_Saida_Final.^2)').*Sim.Ts)'; % ISE (Utilizdo no paper do Murillo)
end
Tempo_FCA = toc;

tic
for i=1:length(SP)
    
    Out_FMIN1(i).Th          = [rand; rand; rand; rand];
    Out_FMIN1(i).PWM         = [rand; rand; rand; rand];
    Out_FMIN1(i).F_out_FCA   = zeros(3,1);
    Out_FMIN1(i).Erro_FCA    = zeros(3,1);
    
    for j=1:length(SP(i).F_unitario_escalado(1,:))
        
        CTRL_IN  = SP(i).F_unitario_escalado(:,j);
        
        if j==1
            % Alocação
            [Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j),Out_FMIN1(i).Erro_FCA(:,j)] = fmincon_use(SP(i).F_unitario_escalado(:,j),zeros(8,1),2);
        else
            % Alocação
            [Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j),Out_FMIN1(i).Erro_FCA(:,j)] = fmincon_use(SP(i).F_unitario_escalado(:,j),[Out_FMIN1(i).PWM;Out_FMIN1(i).Th],j);
        end
        
        %         % Servor Dynamics
        %         [Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j)] = DynamicsOfServosAndMotors(j,Out_FMIN1(i).Th,Out_FMIN1(i).PWM);
        
        % Alocação Direta depois da dinamica dos atuadores
        Out_FMIN1(i).F_Saida(:,j) = Aloc_Direta(Out_FMIN1(i).Th(:,j),Out_FMIN1(i).PWM(:,j));
        % Erro Ponto a ponto
        Out_FMIN1(i).Erro_Saida_Final(:,j) = SP(i).F_unitario_escalado(:,j)- Out_FMIN1(i).F_Saida(:,j);
        
    end
    ISE_FMIN1(:,i) = (sum((Out_FMIN1(i).Erro_Saida_Final.^2)').*Sim.Ts)'; % ISE (Utilizdo no paper do Murillo)
end
Total_FMIN1 = toc;

%% Figuras
Img = ImageParametrization();
Leg = LegendLanguage(Language);


if PlotarCenarios
    for i=1:length(SP)
        %% Força de saida
        Fig = figure(Img.figOpt4L{:})
        ax1 = subplot(311);
        plot(Time,SP(i).F_unitario_escalado(1,:),'b',Img.Line{:}); hold on
        %         plot(Time,Out_FCA(i).F_Saida(1,:),'r',Img.Line{:});
        %         plot(Time,Out_FMIN1(i).F_Saida(1,:),'g',Img.Line{:});
        legend('SP Fx',Img.Legend{:}); xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel{:},Img.YLabelOpt{:});
        grid on
        
        ax2 = subplot(312);
        plot(Time,SP(i).F_unitario_escalado(2,:),'b',Img.Line{:});hold on
        %         plot(Time,Out_FCA(i).F_Saida(2,:),'r',Img.Line{:});
        %         plot(Time,Out_FMIN1(i).F_Saida(2,:),'g',Img.Line{:});
        legend('SP Fy',Img.Legend{:}) ; xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel{:},Img.YLabelOpt{:});
        grid on
        
        ax3 = subplot(313);
        plot(Time,SP(i).F_unitario_escalado(3,:),'b',Img.Line{:});hold on
        %         plot(Time,Out_FCA(i).F_Saida(3,:),'r',Img.Line{:});
        %         plot(Time,Out_FMIN1(i).F_Saida(3,:),'g',Img.Line{:});
        legend('SP $\tau_{n}$',Img.Legend{:}) ; xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel2{:},Img.YLabelOpt{:});
        grid on
        
        %         %% PWM de saida
        %         figure
        %         ax(1) = subplot(411);
        %         plot(Time,Out(i).PWM(1,:),'b'); hold on
        %         legend('Motor 1') ; title('PWM');    grid on
        %
        %         ax(2) = subplot(412);
        %         plot(Time,Out(i).PWM(2,:),'b'); hold on
        %         legend('Motor 2') ;    grid on
        %
        %         ax(3) = subplot(413);
        %         plot(Time,Out(i).PWM(3,:),'b'); hold on
        %         legend('Motor 3') ;    grid on
        %
        %         ax(4) = subplot(414);
        %         plot(Time,Out(i).PWM(4,:),'b'); hold on
        %         legend('Motor 4') ;    grid on
        %         % linkaxes(ax,'xy')
        %
        %         %% Theta de saida
        %         figure
        %         ax(1) = subplot(411);
        %         plot(Time,Out(i).Th(1,:).*(180/pi),'b'); hold on
        %         legend('Theta 1') ; title('Angulo');    grid on
        %
        %         ax(2) = subplot(412);
        %         plot(Time,Out(i).Th(2,:).*(180/pi),'b'); hold on
        %         legend('Theta 2') ;    grid on
        %
        %         ax(3) = subplot(413);
        %         plot(Time,Out(i).Th(3,:).*(180/pi),'b'); hold on
        %         legend('Theta 3') ;    grid on
        %
        %         ax(4) = subplot(414);
        %         plot(Time,Out(i).Th(4,:).*(180/pi),'b'); hold on
        %         legend('Theta 4') ;    grid on
        %         % linkaxes(ax,'xy')
        %
        %         %% Error
        %         figure
        %         ax(2) = subplot(311);
        %         plot(Time,Out(i).Erro_Saida_Final(1,:),'b'); hold on
        %         legend('Fx FCA') ; title('Erro Final');    grid on
        %
        %         ax(1) = subplot(312);
        %         plot(Time,Out(i).Erro_Saida_Final(2,:),'b'); hold on
        %         legend('Fy FCA') ; title('Erro Final');    grid on
        %
        %         ax(3) = subplot(313);
        %         plot(Time,Out(i).Erro_Saida_Final(3,:),'b'); hold on
        %         legend('Tn FCA') ; title('Erro Final');    grid on
        %
        %         drawnow
    end
end


%% Força de saida
FigSPs = figure(Img.figOpt4L{:})
ax1 = subplot(311);
plot(Time,SP(i).F_unitario_escalado(1,:),'b',Img.Line{:}); hold on
legend('SP Fx',Img.Legend{:}); xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel{:},Img.YLabelOpt{:});
grid on

ax2 = subplot(312);
plot(Time,SP(i).F_unitario_escalado(2,:),'b',Img.Line{:});hold on
legend('SP Fy',Img.Legend{:}) ; xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel{:},Img.YLabelOpt{:});
grid on

ax3 = subplot(313);
plot(Time,SP(i).F_unitario_escalado(3,:),'b',Img.Line{:});hold on
legend('SP $\tau_{n}$',Img.Legend{:}) ; xlabel(Leg.Xlabel2{:},Img.XLabelOpt{:}); ylabel(Leg.Ylabel2{:},Img.YLabelOpt{:});
grid on

Fig = figure(Img.figOpt4L{:})
ax1 = subplot(311);
plot(ISE_FCA(1,:),'b',Img.Line{:}); hold on
plot(ISE_FMIN1(1,:),'r',Img.Line{:});
legend(Leg.ISE{:},Img.Legend{:}); title(Leg.Title1{:},Img.TlabelOpt{:}); xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
grid on

ax2 = subplot(312);
plot(ISE_FCA(2,:),'b',Img.Line{:}); hold on
plot(ISE_FMIN1(2,:),'r',Img.Line{:});
legend(Leg.ISE{:},Img.Legend{:}); title(Leg.Title2{:},Img.TlabelOpt{:}); xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
grid on

ax3 = subplot(313);
plot(ISE_FCA(3,:),'b',Img.Line{:}); hold on
plot(ISE_FMIN1(3,:),'r',Img.Line{:});
legend(Leg.ISE{:},Img.Legend{:}); title(Leg.Title3{:},Img.TlabelOpt{:}); xlabel(Leg.Xlabel{:},Img.XLabelOpt{:});
grid on

linkaxes([ax1 ax2 ax3],'xy')

display('FCA Output')
Tempo_FCA
MeanISE_FCA   = sum(ISE_FCA')./length(ISE_FCA)

display('FMINCON Output')
Total_FMIN1
MeanISE_FMIN1 = sum(ISE_FMIN1')./length(ISE_FMIN1)

if save
saveas(FigSPs,'Example_SP','epsc');
saveas(FigSPs,'Example_SP','fig');

saveas(Fig,'ISE_Error','epsc');
saveas(Fig,'ISE_Error','fig');

end
