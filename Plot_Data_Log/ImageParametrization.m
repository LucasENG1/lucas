function Img = ImageParametrization()
%%  OPÇÕES De FIGURA
% Configuração geral
Screen = [0.2 0.2 .25 .55];
Img.figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

% Configuração para 2 subplots
Screen = [0.2 0.2 .65 .5];
Img.figOpt2L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

% Configuração para 3 subplots
Screen = [0.2 0.2 .65 .65];
Img.figOpt3L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

% Configuração para 4 subplots
Screen = [0.1 0 .55 .75];
Img.figOpt4L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

% Configuração para 1 subplots
Screen = [0.2 0.2 .65 0.5*.5];
Img.figOpt1L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

%% Configuração de legenda e título
Img.XLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',12};
Img.YLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',12};
Img.TLabelOpt = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',13};
Img.Legend    = {'Interpreter','latex','FontWeight','normal','FontName', 'Times New Roman','FontSize',11};
Img.COR = [0.3 1 0.4]./2;

end