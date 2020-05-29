function [XYZ] = Rot_pose_motor(yaw,px,py)

M_rotacao = BF2NED(yaw,eye(3));

%% SEMPRE QUE PLOTAR POSIÇÃO - TROCAR X POR Y POR CONTA DO FRAME DO BARCO
XYZ = M_rotacao * ([py ;px ; 0]);

end