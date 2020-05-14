function yaw  = corrigeyaw(yaw)
% corrige o angulo em radianos
ax =0;
for i=2:length(yaw)
    if(abs((yaw(i)-yaw(i-1)))>(pi/2))
        ax = i;
        
    end
end
if (ax~=0)
    yaw(1,ax:end) = yaw(1,ax:end)+2*pi;
end
end