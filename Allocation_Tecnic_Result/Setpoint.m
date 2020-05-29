function [X,Y,TN] = Setpoint(Name,ft)
g = -0.95:0.05:0.95;
switch Name
    case 'Cenario1'
        % Cenario com valores total em Força
        X  = ([1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1,g,1]);
        Y  = ([-1,g,1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1]);
        TN = zeros(1,length(X));
    case 'Cenario2'
        % Cenario que porcentagem nos valores
        X = ([1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1,g,1]);
        Y = ([-1,g,1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1]);
        v =  ceil(length(X)/4);
        TN = ([zeros(1,v), ones(1,v),-ones(1,v),zeros(1,v)]);
        X  = ft*X;
        Y  = ft*Y;
        TN = ft*TN;
    case 'Cenario3'
        % Cenario com valores totalem Força e Torque ( Problematico)
        X  = ([1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1,g,1]);
        Y  = ([1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1,g,1]);
        %         ([-1,g,1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1]);
        TN = ([1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1,g,1]);
        
    case 'Torque'
        X  = ([1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1,g,1]);
        X  =  zeros(1,length(X));
        Y  =  zeros(1,length(X));
        TN = ([1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1,g,1]);
        
    case 'Cenario4'
        % Cenario com valores total em Força
        X  = ([1,ones(1,length(g)),1,-g,-1,-ones(1,length(g)),-1,g,1]);
        Y  = zeros(1,length(X));
        TN = zeros(1,length(X));
    otherwise
        X=0;
        Y=0;
end
end