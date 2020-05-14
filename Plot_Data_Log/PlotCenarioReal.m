function PlotCenarioReal(T,Pose_real,Vel_real,Nome,Language,salva)
global SP RAD_TO_DEG;

Img = ImageParametrization();
Leg = LegendLanguage(Language);

%% POSI��O 3D
switch Nome 
    case 'LinearX_Real'
        Screen = [0 0 1 1];
        figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto',...
        'Position',Screen};
    posi3D = figure(figOpt{:});
    otherwise
posi3D = figure(Img.figOpt{:});
end
plot(SP.X,SP.Y,'r','linewidth',2);hold on;axis equal
plot(Pose_real(1,:),Pose_real(2,:),'color',Img.COR,'linewidth',2)
FiguraArtigo(10,Pose_real); grid on;
xlabel('Y (m)',Img.YLabelOpt{:});
ylabel('X (m)',Img.YLabelOpt{:});
legend(Leg.p3D{:},Img.Legend{:});
%% POSI��O EM CADA COMPONENTE
posi3L=figure(Img.figOpt3L{:});
ax1 = subplot(311);
% plot(SP.t,SP.Y,'r','linewidth',2);hold on
plot(T,Pose_real(2,:),'color',Img.COR,'linewidth',2);grid on
legend(Leg.posicaoX3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YP3L{:},Img.YLabelOpt{:});

ax2 = subplot(312);
% plot(SP.t,SP.X,'r','linewidth',2);hold on
plot(T,Pose_real(1,:),'color',Img.COR,'linewidth',2);grid on
legend(Leg.posicaoY3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YP3L{:},Img.YLabelOpt{:});

ax3 = subplot(313);
% plot(SP.t,SP.Yaw*RAD_TO_DEG,'r','linewidth',2);hold on;
plot(T,rem(Pose_real(3,:),2*pi)*RAD_TO_DEG,'color',Img.COR,'linewidth',2);grid on
legend(Leg.posicaoYaw3L{1},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.yaw3L{:},Img.YLabelOpt{:});

linkaxes([ax1 ax2 ax3],'x')
xlim([0 T(end)])

%%  VELOCIDADE
vel3L=figure(Img.figOpt3L{:});
vx1 = subplot(311);
plot(T,Vel_real(1,:),'color',Img.COR,'linewidth',2);hold on;grid on
legend(Leg.VelX3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YV3L{:},Img.YLabelOpt{:});

vx2 = subplot(312);
plot(T,Vel_real(2,:),'color',Img.COR,'linewidth',2);hold on ;grid on
legend(Leg.VelY3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YV3L{:},Img.YLabelOpt{:});

vx3 = subplot(313);
plot(T,Vel_real(3,:),'color',Img.COR,'linewidth',2);hold on;grid on;
legend(Leg.VelYaw3L{:},Img.Legend{:});
xlabel(Leg.XP3L{:},Img.XLabelOpt{:});
ylabel(Leg.YYaw3L{:},Img.YLabelOpt{:});

linkaxes([vx1 vx2 vx3],'x')
xlim([0 T(end)])

switch Nome
    case 'LinearX_Real'
        figure(posi3D);
        axis([-15 15 -2 143]);
        % posi��o
        ylim(ax1,[0 150]);
        ylim(ax2,[-15 15]);
        ylim(ax3,[-50 100]);
        legend(Leg.p3D{:},Img.Legend{:},'NumColumns',1,'Location','northoutside');
        
        figure(vel3L)
        ylim(vx1,[-0 4]);
        ylim(vx2,[-0 4]);
        ylim(vx3,[-20  25]);
        xlim([0 T(end)])
        
    case 'Oito_Real'
        figure(posi3D);
        ylim([min([SP.Y Pose_real(2,:)])-2 max([SP.Y Pose_real(2,:)])+7])
        xlim([min([SP.X Pose_real(1,:)])-2 max([SP.X Pose_real(1,:)])+2])
        %         axis([-20 10 -55 10]);
        % posi��o
        ylim(ax1,[-60 5]);
        ylim(ax2,[-30 30]);
        ylim(ax3,[-50 250]);
        
        % velocidade
        ylim(vx2,[-.5 1])
        
    case 'Sway_Real'
        figure(posi3D);
        axis([-2 70 -2 5]);
        
        figure(posi3L)
        ylim(ax1,[-1 60]);
        ylim(ax2,[0  70]);
        ylim(ax3,[-220  50]);
        xlim([0 T(end)])
        
        figure(vel3L)
        ylim(vx1,[-2 3]);
        ylim(vx2,[-2 3]);
        ylim(vx3,[-75  70]);
        xlim([0 T(end)]);
        
    case 'Circular_Real'
        figure(posi3D);
        axis([10.25-17 10.25+17 11.25-17 11.25+17]);
        
        figure(posi3L)
        ylim(ax1,[10.25-20 10.25+20]);
        ylim(ax2,[11.25-20 11.25+20]);
        ylim(ax3,[-190  190]);
        xlim([0 T(end)])
        
        figure(vel3L)
        ylim(vx1,[-1 2.5]);
        ylim(vx2,[-1 2.5]);
        ylim(vx3,[-30 25]);
        xlim([0 T(end)])
        
    otherwise
end
if(salva==1)
    saveas(posi3D,strcat(Nome,'Posicao3D'),'epsc');
    saveas(posi3D,strcat(Nome,'Posicao3D'),'fig');
    
    saveas(posi3L,strcat(Nome,'Posicao3L'),'epsc');
    saveas(posi3L,strcat(Nome,'Posicao3L'),'fig');
    
    saveas(vel3L,strcat(Nome,'Velocidade3L'),'epsc');
    saveas(vel3L,strcat(Nome,'Velocidade3L'),'fig');
end


