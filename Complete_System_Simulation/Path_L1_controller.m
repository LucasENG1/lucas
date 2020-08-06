function Path_L1_controller(stp)
global Sim WP SP Sat ;
groundspeed_vector = Sim.Current_u_v_r(1:2);
groundSpeed = norm(Sim.Vel(1:2,stp));
% L1_dist = 10 * groundSpeed;

L1_damping = 0.7071;
L1_period = 80;

K_L1 = 4.0 * L1_damping * L1_damping;

L1_dist = 0.3183099 * L1_damping * L1_period * groundSpeed;

target_bearing_cd = get_bearing(Sim.Current_X_Y_psi(1:2),SP.XYZ(1:2,WP));

if (groundSpeed < 0.1)
    groundSpeed = 0.1;
    groundspeed_vector = [cos(Sim.Current_X_Y_psi(3)); sin(Sim.Current_X_Y_psi(3))] * groundSpeed;
end

AB = location_diff(SP.XYZ(1:2,WP-1),SP.XYZ(1:2,WP));

AB_length = norm(AB);

if (norm(AB) < 1.0e-6)
    AB = location_diff(Sim.Current_X_Y_psi(1:2), SP.XYZ(1:2,WP));
    AB_length = norm(AB);
    if (AB_length < 1.0e-6)
        AB = [cos(Sim.Current_X_Y_psi(3)), sin(Sim.Current_X_Y_psi(3))];
    end
end

Air = location_diff(SP.XYZ(1:2,WP-1),Sim.Current_X_Y_psi(1:2));

crosstrack_error = prodCross(Air,AB);

WP_A_dist  = norm(Air);

alongTrackDist  = Air'*AB;

if (WP_A_dist > L1_dist)&&((alongTrackDist/max([WP_A_dist, 1.0]))< -0.7071)
    %Calc Nu to fly To WP A
    A_air_unit = Air./norm(Air);
    xtrackVel = prodCross(groundspeed_vector,-A_air_unit);
    ltrackVel = groundspeed_vector' * -A_air_unit;
    Nu = atan2(xtrackVel,ltrackVel);
    nav_bearing = atan2(A_air_unit(2), A_air_unit(1)); %// bearing (radians) from AC to L1 point
elseif(alongTrackDist > (AB_length + groundSpeed*3))
    B_air = location_diff(SP.XYZ(1:2,WP),Sim.Current_X_Y_psi(1:2));
    B_air_unit = B_air/norm(B_air);% // Unit vector from WP B to aircraft
    xtrackVel = prodCross(groundspeed_vector, (-B_air_unit));% // Velocity across line
    ltrackVel = groundspeed_vector' * (-B_air_unit);% // Velocity along line
    Nu = atan2(xtrackVel,ltrackVel);
    nav_bearing = atan2(B_air_unit(2) , B_air_unit(1));% // bearing (radians) from AC to L1 point
else   %//Calculate Nu2 angle (angle of velocity vector relative to line connecting waypoints)
    xtrackVel = prodCross(groundspeed_vector,AB); %// Velocity cross track
    ltrackVel = groundspeed_vector' * AB; %// Velocity along track
    Nu2 = atan2(xtrackVel,ltrackVel);
    % //Calculate Nu1 angle (Angle to L1 reference point)
    sine_Nu1 = crosstrack_error/max([L1_dist, 0.1]);
    % //Limit sine of Nu1 to provide a controlled track capture angle of 45 deg
    sine_Nu1 = Satura(sine_Nu1, 0.7071, -0.7071);
    Nu1 = asin(sine_Nu1);
    
    Nu1 = Nu1 + 0;
    
    Nu = Nu1 + Nu2;
    nav_bearing = atan2(-AB(2), -AB(1)) + 0*Nu1 %// bearing (radians) from AC to L1 point OLHAR ESSA LINHA
end

Nu = Satura(Nu, 1.5708, -1.5708);
latAccDem = K_L1 * groundSpeed * groundSpeed / L1_dist * sin(Nu);

SP.XYZ(3,WP) = nav_bearing;

Sim.Vel(1,stp) = groundSpeed;
Sim.Vel(2,stp) = latAccDem;

%% Saturações
Sim.Vel(1,stp) = Satura(Sim.Vel(1,stp),Sat.MaxVelX,-Sat.MaxVelX);
Sim.Vel(2,stp) = Satura(Sim.Vel(2,stp),Sat.MaxVelY,-Sat.MaxVelY);

%---------------------------------------------
E = norm(SP.XYZ(1:2,WP) - Sim.Current_X_Y_psi(1:2));

if E <1 && WP> (length(SP.XYZ(1,:))-10)
    Sim.Vel(:,stp) = zeros(3,1);
end

end
% nav_bearing = mod(nav_bearing , 2*pi);
% if nav_bearing > pi, nav_bearing = nav_bearing - 2*pi; end


