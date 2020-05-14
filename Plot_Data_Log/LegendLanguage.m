function Leg = LegendLanguage(language)

switch language
    case 'Portugues'
        Leg.p3D= {'Caminho a desenvolver','Caminho desenvolvido','NumColumns',2,'Location','northoutside'};
        Leg.posicaoX3L = {'Posi\c{c}\~{a}o $X$','Location','northeast'};
        Leg.posicaoY3L = {'Posi\c{c}\~{a}o $Y$','Location','northeast'};
        Leg.posicaoYaw3L = {'Posi\c{c}\~{a}o $\psi$','Location','northeast'};
        Leg.Alocacao = {'Desejado','Alocado','Location','best'};
        Leg.VelX3L = {'Velocidade X','Location','best'};
        Leg.VelY3L = {'Velocidade Y','Location','best'};
        Leg.VelYaw3L = {'Velocidade $\psi$','Location','best'};
        
        Leg.X3D = {'X (m)'};
        Leg.Y3D = {'Y (m)'};
        Leg.XP3L = {'Tempo (s)'};
        Leg.YP3L ={'Dist\^ ancia (m)'};
        Leg.yaw3L = {'\^ Angulo (Grau)'};
        Leg.Forca = {'For\c{c}a (N)'};
        Leg.Torque = {'Torque (N.m)'};
        Leg.YV3L ={'Velocidade (m/s)'};
        Leg.YYaw3L ={'Velocidade Angular (Grau/s)'};
        
    case 'Ingles'
        Leg.p3D= {'Path to follow','Developed path','NumColumns',2,'Location','northoutside'};
        Leg.posicaoX3L = {'$X$ position','Location','best'};
        Leg.posicaoY3L = {'$Y$ position','Location','best'};
        Leg.posicaoYaw3L = {'$\psi$ position','Location','best'};
        Leg.Alocacao = {'Desired','Allocated','Location','best'};
        Leg.VelX3L = {'$X$ velocity ','Location','best'};
        Leg.VelY3L = {'$Y$ velocity','Location','best'};
        Leg.VelYaw3L = {'$\psi$ velocity','Location','best'};
        
        Leg.X3D = {'X (m)'};
        Leg.Y3D = {'Y (m)'};
        Leg.XP3L = {'Time (s)'};
        Leg.YP3L ={'Distance (m)'};
        Leg.yaw3L = {'Angle (Degree)'};
        Leg.Forca = {'Force (N)'};
        Leg.Torque = {'Torque (N.m)'};
        Leg.YV3L ={'Speed (m/s)'};
        Leg.YYaw3L ={'Angular speed (Deg/s)'};
        
    otherwise
        Leg = 0;
end
end