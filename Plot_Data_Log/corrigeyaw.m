function yaw  = corrigeyaw(yaw)
% corrige o angulo em radianos
ax =0;
for i=2:length(yaw)
    if(abs(yaw(i)-yaw(i-1))>(pi))
       if((yaw(i)-yaw(i-1))>0)
           yaw(i) = yaw(i)-2*pi;
       else
           yaw(i) = yaw(i)+2*pi;
       end
        
    end
end
end