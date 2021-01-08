function Leg = LegendLanguage(language)


switch language
    case 'Portugues'
        Leg.Algorit         = {'FCA','Conjunto Ativado','Pontos Interiores','Location','best'};
        Leg.Title1       = {'ISE Fx'};
        Leg.Title2       = {'ISE Fy'};
        Leg.Title3       = {'ISE $\tau_{n}$'};
        Leg.Xlabel       = {'Simula\{c}c\{~}ao'};
        Leg.Xlabel2      = {'Tempo (s)'};
        Leg.Ylabel      = {'For\{c}ca (N)'};
        Leg.Ylabel2      = {'Torque (N.m)'};
        
    case 'Ingles'
        Leg.Algorit      = {'FCA','Active-set','Interior-point','Location','best'};
        Leg.Title1       = {'ISE Fx'};
        Leg.Title2       = {'ISE Fy'};
        Leg.Title3       = {'ISE $\tau_{n}$'};
        Leg.Xlabel       = {'Simulation'};
        Leg.Xlabel2       = {'Time (s)'};
        Leg.Ylabel      = {'Force (N)'};
        Leg.Ylabel2      = {'Torque (N.m)'};        
    otherwise
        Leg = 0;
end
end