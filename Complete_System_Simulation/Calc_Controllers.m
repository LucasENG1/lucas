% calcula todos os controladores da malha de velocidade e de posição
function Calc_Controllers()
global Ctrl ;

%% Control data structure (Ctrl)
ErrPXYZprev  = zeros(3,1);
ErrIXYZprev  = zeros(3,1);
ErrPVXYZprev = zeros(3,1);
ErrIVXYZprev = zeros(3,1);

%% Position control gain
[kpPosi,kiPosi,kdPosi] = Calc_Position_Controller(10);

%% Speed Control gain
[kpVel,kiVel,kdVel] = Calc_Speed_Controller(1,2,2);

Ctrl = struct('kpPosi',kpPosi,'kiPosi',kiPosi,'kdPosi',kdPosi,'ErrPXYZprev',...
    ErrPXYZprev,'ErrIXYZprev',ErrIXYZprev,'kpVel',kpVel,'kiVel',kiVel,'kdVel',...
    kdVel,'ErrPVXYZprev',ErrPVXYZprev,'ErrIVXYZprev',ErrIVXYZprev);
end