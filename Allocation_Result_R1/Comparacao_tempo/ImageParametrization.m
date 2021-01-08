function Img = ImageParametrization()
%%  OPÇÕES DA FIGURA

Screen = [.1 0 .65 .9];
Img.figOpt4L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};
Screen = [.1 0 .65 .55];
Img.figOpt2L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

Img.XLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',17};
Img.YLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',17};
Img.TlabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',17};
Img.Legend    = {'Interpreter','latex','FontWeight','normal','FontName', 'Times New Roman','FontSize',17};
Img.COR = [0.3 1 0.4]./2;

Img.Line = {'Markersize',10};

end