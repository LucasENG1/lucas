function NoiseInitialization

global R_gps std_gps_x std_gps_yaw
% -------- GPS --------
% Desvio padrao em x [metros]
std_gps_yaw = 0*2*pi/180;

std_gps_x = 0*0.01;
% Covariancia
R_gps = [std_gps_x^2        0           0
            0           std_gps_x^2     0
            0               0           std_gps_yaw^2 ];
        
        
end
        


