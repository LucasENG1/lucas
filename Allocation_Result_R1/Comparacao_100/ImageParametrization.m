function Img = ImageParametrization()
%%  OPÇÕES DA FIGURA

Screen = [.1 0 .65 .9];
Img.figOpt4L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

Screen = [0 0 1 2];
Img.figOpt10L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

Img.XLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',17};
Img.YLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',17};
Img.TlabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',17};
Img.Legend    = {'Interpreter','latex','FontWeight','normal','FontName', 'Times New Roman','FontSize',17};
Img.COR = [0.3 1 0.4]./2;

Img.SP   = {':k','linewidth',2};
Img.FCA   = {'-b','linewidth',2};
Img.FMIN1 = {'-.','color',[0 .5 0],'linewidth',2};
Img.FMIN2 = {'--m','linewidth',2};


Img.TFCA   = {'-b','markersize',10,'linewidth',2};
Img.TFMIN1 = {'-.','color',[0 .5 0],'markersize',10,'linewidth',2};
Img.TFMIN2 = {'--m','markersize',10,'linewidth',2};

Img.Line = {'linewidth',2};

Img.Par = {'Units', 'Normalized','XGrid','on','YGrid','on','FontName', 'Times New Roman', 'FontSize', 10};%, 'GridLineStyle',...
%     '--', 'MinorGridLineStyle', ':', 'XMinorTick', 'on', 'YMinorTick', 'on', 'Box', 'off'};

end
