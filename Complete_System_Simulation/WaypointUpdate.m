function WaypointUpdate()
global WP SP Sim ROV;

if((norm(SP.XYZ(1:2,WP) - Sim.Current_X_Y_psi(1:2)))<ROV.WpRadius && WP<length(SP.XYZ(1,:)))
    WP = WP+1;
end

end