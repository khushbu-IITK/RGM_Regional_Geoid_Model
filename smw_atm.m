function [Anom_smw_atm, lati, longi]  = smw_atm()
  % Creating the variable for file downloaded from NGS GRAVD site.
filename = 'NGS_GRAVD_Block_CS06_Gravity_Data_BETA1.txt' ;

% Extracting data i.e. Lat, long, elevation and gravity observation.
[lati,longi, elevation,obs_grav] = Extract_Data(filename);

% Computing normal gravity
gama = compute_normal_gravity_84(lati);

%compute free air reduction
Free_Air_reduction = compute_Free_Air_reduction(elevation);

% compute gravity anomaly
Grav_Anom = obs_grav + Free_Air_reduction - gama ;

create_grid(Grav_Anom, 0.01, lati, longi);

% path array for GGM data files
Path = ['GGM05C_1.dat'; 'GGM05C_2.dat'; 'GGM05C_3.dat'; 'GGM05C_4.dat'; 'GGM05C_5.dat'; 'GGM05C_6.dat'; 'GGM05C_7.dat'; 'GGM05C_8.dat'; 'GGM05C_9.dat';  'GGM05C_10.dat'; 'GGM05C_11.dat'; 'GGM05C_12.dat'; 'GGM05C_13.dat'; 'GGM05C_14.dat'];
% Extracting data from GGM data files
[Long_ggm, lat_ggm, height_anom_ggm, gravity_anom_ggm] = Extract_GGM(Path);

% compute reduced gravity anomaly
reduced_Grav_Anom = Grav_Anom - gravity_anom_ggm ;

% computing atmospheric correction
atmospheric_correction = compute_atm_correction(ortho_Height) ;

% Computing Gravity anomaly after applying free air and atmospheric correction => Gravity Anomaly Smw Atm
Anomaly_smw_atm = Reduced_gravity_anom - atmospheric_correction ;
  Anom_smw_atm = Anomaly_smw_atm ;
  lat_dem = linspace(min(lati), max(lati), 1320);  % Defining the latitude range taking a buffer of 0.5 degree
lon_dem = linspace(min(longi), max(longi), 1320);  % Defining the longitude range taking a buffer of 0.5 degree
[X_dem, Y_dem] = meshgrid(lon_dem, lat_dem);
end
