function [normal_gravity] = compute_normal_gravity_84(lat)
  %calculates Normal Gravity for data point with a given latitude for WGS84 Reference Ellipsoid.
  %INPUT -
  %  lat (double) - (degree) Latitudes of the data points

  %OUTPUT -
  %   normal_gravity (double) - (mGal) Normal Gravity with respect to the given ellipsoid

  % for WGS84 ellipsoid
  a = 6378137 ; % in meters % Semi major axis
  b = 6356752.3142; % in meters % semi minor axis
  Gama_a = 9.7803253359; % in m/s2 % Normal gravity value at the equator
  Gama_b = 9.8321849378; %in m/s2  % Normal gravity value at the pole

  % Factor to convert degree to radian
  deg2red = pi/180;

  % denominator for the normal gravity
  denomi = sqrt(((a.^2)*cos(lat*deg2red).^2) + ((b.^2)*sin(lat*deg2red).^2));
  normal_gravity = ((a*Gama_a.*(cos(lat*deg2red).^2)) + (b*Gama_b.*(sin(lat*deg2red).^2)))./denomi; % in m/s^2
  normal_gravity = normal_gravity*(10^5) ; % converted it in mGal
endfunction
