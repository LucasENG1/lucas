function Img = ImageParametrization()
%%  OPÇÕES DA FIGURA
Screen = [0.2 0.2 .25 .55];
Screen = [0.2 0.2 .25 .55];
Img.figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};
% quando tem 3 linhas de saida na figura
Screen = [0.2 0.2 .65 .65];
Img.figOpt3L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

Screen = [0.2 0.2 .65 .5];
Img.figOpt2L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

Screen = [0.2 0.2 .65 0.5*.5];
Img.figOpt1L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};
% quando tem 3 linhas de saida na figura
Screen = [0.1 0 .55 .75];
Img.figOpt4L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

Img.XLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',12};
Img.YLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',12};
Img.TlabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',13};
Img.Legend    = {'Interpreter','latex','FontWeight','normal','FontName', 'Times New Roman','FontSize',11};
Img.COR = [0.3 1 0.4]./2;

end