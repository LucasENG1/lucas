function [Px, Py] = LatLonToMeters2(lat,lon)

%Vinicius

dlat = lat - lat(1);
dlon = lon - lon(1);
D = sqrt((dlat.*dlat) + (dlon.*dlon)) .* 111315.6;

theta = atan(dlon./dlat);
theta(isnan(theta))=0;

Px = D.*cos(theta);
Py = D.*sin(theta);
