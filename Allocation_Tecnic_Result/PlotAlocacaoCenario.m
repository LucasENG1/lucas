function PlotAlocacaoCenario(TN,X,Y,Xmap,Ymap,TNmap,F,F_out,Pwm,theta,ft,Nome,salva)
global Fmax Nmax;
ax = 0;
for i=2:length(X)
    if((norm([X(i) Y(i) TN(i)])==ft ||norm([X(i) Y(i) TN(i)])==sqrt(ft^2+ft^2+ft^2)))
        ax = ax+1;
        st(ax) = strcat('\bf{',string(ax-1),'}');
        I(ax) = i;
    end
end

G = [.1 .2 .3 .4 .5 .6 .7 .8];

%%  OPÇÕES DA FIGURA
Screen = [.2 .2 .5 .5];

figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};
% quando tem 3 linhas de saida na figura
Screen = [.2 .2 .5 .6];
figOpt3L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};
% quando tem 3 linhas de saida na figura
Screen = [.2 .1 .5 .75];
figOpt4L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

XLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',10};
YLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',13};
TlabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',14};

%% SP DE FORÇAS NORMALIZADOS
figure(figOpt3L{:});
ax1 = subplot(3,6,[1 2 3 4]);
plot(X,'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$F_x $',YLabelOpt{:});
text(I,X(I)+.1*ft.*ones(1,length(I)),st,'Interpreter','latex');
axis([0 (length(X)+1) ft.*-1.3 ft.*1.3]); box on;

ax2 = subplot(3,6,[7 8 9 10]);
plot(Y,'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$F_y$',YLabelOpt{:});
text(I,Y(I)+.1*ft.*ones(1,length(I)),st,'Interpreter','latex'); box on;
axis([0 (length(Y)+1) ft.*-1.3 ft.*1.3]); box on;

ax3 = subplot(3,6,[13 14 15 16]);
plot(TN,'b','linewidth',2);hold on;grid on;
axis([0 (length(TN)+1) ft.*-1.3 ft.*1.3]);
xlabel('Amostra',XLabelOpt{:});
ylabel('$\tau_{\psi}$',YLabelOpt{:});
text(I,.1*ft.*ones(1,length(I)),st,'Interpreter','latex'); box on;

linkaxes([ax1 ax2 ax3],'x')

ax4 = subplot(3,6,[5 6 11 12]);
plot(X,Y,'b','linewidth',2);hold on;grid on;
axis equal
axis(ft.*[-1.3 1.3 -1.3 1.3])
text(X(I),Y(I),st,'Interpreter','latex'); box on;

ax5 = subplot(3,6,[17 18]);
plot(TN,zeros(1,length(TN)),'+b','linewidth',2);hold on;grid on;
axis(ft.*[-1.3 1.3 -1.3 1.3]);axis equal
switch Nome
    case 'Cenario2'
        text(TN(I),ft.*G(1:length(I)),st,'Interpreter','latex');
    case 'Cenario1'
        text(TN(I),ft.*G(1:length(I)),st,'Interpreter','latex');
    otherwise
end
linkaxes([ax4 ax5],'xy')

if(salva==1)
    saveas(gcf,strcat(Nome,'_SRCNormal'),'epsc');
    saveas(gcf,strcat(Nome,'_SRCNormal'),'fig');
end
%% SP NORMALIZADO MAPEADO
figure(figOpt3L{:})
ax1 = subplot(3,6,[1 2 3 4 5 6]);
plot(Xmap,'r','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$F_x$' ,YLabelOpt{:});
text(I,Xmap(I)+.1*ft.*ones(1,length(I)),st,'Interpreter','latex'); box on;
axis([0 (length(X)+1) ft.*-1.3 ft.*1.3]);

ax2 = subplot(3,6,[7 8 9 10 11 12]);
plot(Ymap,'r','linewidth',2);hold on ;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$F_y$',YLabelOpt{:});
text(I,Ymap(I)+.1*ft.*ones(1,length(I)),st,'Interpreter','latex'); box on;
axis([0 (length(X)+1) ft.*-1.3 ft.*1.3]);

ax3 = subplot(3,6,[13 14 15 16 17 18]);
% scatter(X(I),Y(I),150,[1 0 0])
plot(TNmap,'r','linewidth',2);hold on;grid on;
axis([0 (length(TNmap)+1) ft.*-1.3 ft.*1.3]);
xlabel('Amostra',XLabelOpt{:});
ylabel('$\tau_{\psi}$',YLabelOpt{:});
text(I,.1*ft.*ones(1,length(I)),st,'Interpreter','latex'); box on;
linkaxes([ax1 ax2 ax3],'x');

if(salva==1)
    saveas(gcf,strcat(Nome,'_SRCMapeado'),'epsc');
    saveas(gcf,strcat(Nome,'_SRCMapeado'),'fig');
end
    
%% STICKS DO RADIO CONTROLE
figure(figOpt{:})

ax2 = subplot(1,2,1);
plot(TN,zeros(1,length(TN)),'+r','linewidth',2);hold on;grid on;axis equal
ylabel('Canal n\~{a}o utilizado',YLabelOpt{:});
xlabel('$\tau_\psi $',YLabelOpt{:});
axis(ft.*[-1.3 1.3 -1.3 1.3]);
legend('Torque',XLabelOpt{:});
switch Nome
    case 'Cenario1'
        text(TN(I),ft.*G(1:length(I)),st,'Interpreter','latex');
    case 'Cenario2'
        text(TN(I),ft.*G(1:length(I)),st,'Interpreter','latex');
    otherwise
end

ax1 = subplot(1,2,2);
plot(Xmap,Ymap,'r','linewidth',2);grid on;axis equal;hold on
ylabel('$F_y $',YLabelOpt{:});
xlabel('$F_x $',YLabelOpt{:});
legend('For\c{c}as',XLabelOpt{:},'Location','northeast'); box on;
text(Xmap(I),Ymap(I),st,'Interpreter','latex');
view(2)
linkaxes([ax1 ax2],'xy');
axis(ft.*[-1.1 1.1 -1.1 1.1]);
if(salva==1)
    saveas(gcf,strcat(Nome,'_RCMapeado'),'epsc');
    saveas(gcf,strcat(Nome,'_RCMapeado'),'fig');
end

%% FORÇA DESEJADA e OBTIDA
figure(figOpt3L{:})
bm1 = subplot(311);
plot(F(1,:) ,'r','linewidth',2);grid on;hold on
plot(F_out(1,:),'b','linewidth',2);
% title('For\c{c}as e Torques',TlabelOpt{:});
legend('Setpoint','Obtido',XLabelOpt{:},'Location','southeast');
ylabel('$F_x$',YLabelOpt{:});
xlabel('Amostra',XLabelOpt{:});
axis([0 (length(F(1,:))+1)  1.2*(min([F(1,:) F_out(1,:)]))  1.2*(max([F(1,:) F_out(1,:)]))]);
text(I,Fmax.*[Xmap(I)+.1*ft.*ones(1,length(I))],st,'Interpreter','latex')
% title('$F_x$','Interpreter','latex','FontWeight','bold');

bm2 = subplot(312);
plot(F(2,:) ,'r','linewidth',2);grid on;hold on
plot(F_out(2,:),'b','linewidth',2);
legend('Setpoint','Obtido',XLabelOpt{:});
ylabel('$F_y$',YLabelOpt{:});
xlabel('Amostra',XLabelOpt{:});
axis([0 (length(F(2,:))+1)  1.2*(min([F(2,:) F_out(2,:)]))  1.2*(max([F(2,:) F_out(2,:)]))]);
text(I,Fmax.*[Ymap(I)+.1*ft.*ones(1,length(I))],st,'Interpreter','latex')
axis([0 (length(X)+5) -1.3 1.3])

bm3 = subplot(313);
plot(F(3,:) ,'r','linewidth',2);grid on;hold on
plot(F_out(3,:),'b','linewidth',2);
legend('Setpoint','Obtido',XLabelOpt{:});
ylabel('$\tau_\psi $',YLabelOpt{:});
xlabel('Amostra',XLabelOpt{:});
axis([0 (length(X)+5) -1.3 1.3])

if((min([F(3,:) F_out(3,:)]))< (max([F(3,:) F_out(3,:)]))&& abs(max([F(3,:) F_out(3,:)]))>1 )
    axis([0 (length(F(3,:))+1) 1.2*(min([F(3,:) F_out(3,:)]))  1.2*(max([F(3,:) F_out(3,:)]))]);
    text(I,Nmax.*[TN(I)+.1*ft.*ones(1,length(I))],st,'Interpreter','latex'); box on;
else
%     axis([0 (length(F(3,:))+1) -1  1]);
axis([0 (length(F(3,:))+1)  1.2*(min([F(3,:) F_out(3,:)]))  1.2*(max([F(3,:) F_out(3,:)]))]);
    text(I,[TN(I)+.1*ft.*ones(1,length(I))],st,'Interpreter','latex'); box on;
end
axis([0 (length(X)+5) -1.3 1.3])
linkaxes([bm1 bm2 bm3],'x')
if( salva==1)
    saveas(gcf,strcat(Nome,'_ResultAloc'),'epsc');
    saveas(gcf,strcat(Nome,'_ResultAloc'),'fig');
end

%% ANGULOS DE SAIDA
figure(figOpt4L{:})
am1 = subplot(411);
plot(theta(1,:),'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$Graus$',XLabelOpt{:});
text(I,theta(1,I)+.1*max(theta(1,I))*ft.*ones(1,length(I)),st,'Interpreter','latex')
xlim([0 length(theta(1,:))+1])
% axis([0 (length(X)+5) ft.*-1.3 ft.*1.3])
legend(sprintf('Motor 1')); box on;

am2 = subplot(412);
plot(theta(2,:),'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$Graus$' ,XLabelOpt{:});
text(I,theta(2,I)+.1*max(theta(2,I))*ft.*ones(1,length(I)),st,'Interpreter','latex')
xlim([0 length(theta(2,:))+1])
legend(sprintf('Motor 2')); box on;

am3 = subplot(413);
plot(theta(3,:),'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$Graus$' ,XLabelOpt{:});
text(I,theta(3,I)+.1*max(theta(3,I))*ft.*ones(1,length(I)),st,'Interpreter','latex')
xlim([0 length(theta(3,:))+1]);
legend(sprintf('Motor 3')); box on;

am4 = subplot(414);
plot(theta(4,:),'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$Graus$',XLabelOpt{:});
text(I,theta(4,I)+.1*max(theta(4,I))*ft.*ones(1,length(I)),st,'Interpreter','latex')
xlim([0 length(theta(4,:))+1]);
legend(sprintf('Motor 4')); box on;

linkaxes([am1 am2 am3 am4],'x')
if( salva==1)
    saveas(gcf,strcat(Nome,'_AnguloSaida'),'epsc');
    saveas(gcf,strcat(Nome,'_AnguloSaida'),'fig');
end

%% PWM DE SAIDA
figure(figOpt4L{:})
pm1 = subplot(411);
plot(Pwm(1,:),'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$PWM$',XLabelOpt{:});
text(I,Pwm(1,I)+.1*max(Pwm(1,I))*ft.*ones(1,length(I)),st,'Interpreter','latex')
axis([0 length(Pwm(1,:))+1 0 1.3]);
legend(sprintf('Motor 1')); box on;

pm2 = subplot(412);
plot(Pwm(2,:),'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$PWM$' ,XLabelOpt{:});
text(I,Pwm(2,I)+.1*max(Pwm(2,I))*ft.*ones(1,length(I)),st,'Interpreter','latex')
axis([0 length(Pwm(2,:))+1 0 1.3])
legend(sprintf('Motor 2')); box on;

pm3 = subplot(413);
plot(Pwm(3,:),'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$PWM$' ,XLabelOpt{:});
text(I,Pwm(3,I)+.1*max(Pwm(3,I))*ft.*ones(1,length(I)),st,'Interpreter','latex')
axis([0 length(Pwm(3,:))+1 0 1.3]);
legend(sprintf('Motor 3')); box on;

pm4 = subplot(414);
plot(Pwm(4,:),'b','linewidth',2);hold on;grid on
xlabel('Amostra',XLabelOpt{:});
ylabel('$PWM$',XLabelOpt{:});
text(I,Pwm(4,I)+.1*max(Pwm(4,I))*ft.*ones(1,length(I)),st,'Interpreter','latex')
axis([0 length(Pwm(4,:))+1 0 1.3]);
legend(sprintf('Motor 4')); box on;

if( salva==1)
    saveas(gcf,strcat(Nome,'_PwmSaida'),'epsc');
    saveas(gcf,strcat(Nome,'_PwmSaida'),'fig');
end
linkaxes([pm1 pm2 pm3 pm4],'x')
linkaxes([bm1 am2 pm3],'x')
