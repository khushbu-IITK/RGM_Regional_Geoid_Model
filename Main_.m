% Creating the variable for file downloaded from NGS GRAVD site.
filename = input('Provide the GRAVD file location : ') ;

% Extracting data i.e. Lat, long, elevation and gravity observation.
[lati,longi, elevation,obs_grav] = Extract_Data(filename);
lati = lati' ;
longi = longi' ;
elevation = elevation' ;
obs_grav = obs_grav';
% Computing normal gravity
gama = compute_normal_gravity_84(lati);
%compute free air reduction
Free_Air_reduction = compute_Free_Air_reduction(elevation);
% compute gravity anomaly
Free_Grav_Anom = obs_grav + Free_Air_reduction - gama ;

% path array for GGM data files
Ask = input("Do you want to provide the path array for the GGM05C Dataset(otherwise continue with sample one)? (Y/N) :",'s') ;
Ask = lower(Ask) ;
if (Ask == 'y')
  Path = input('Provide the path of the files in array form: ') ;
else
  Path = ['GGM05C_1.dat'; 'GGM05C_2.dat'; 'GGM05C_3.dat'; 'GGM05C_4.dat'; 'GGM05C_5.dat'; 'GGM05C_6.dat'; 'GGM05C_7.dat'; 'GGM05C_8.dat'; 'GGM05C_9.dat';  'GGM05C_10.dat'; 'GGM05C_11.dat'; 'GGM05C_12.dat'; 'GGM05C_13.dat'; 'GGM05C_14.dat'];
endif
% Extracting data from GGM data files
[Long_ggm, lat_ggm, height_anom_ggm, gravity_anom_ggm] = Extract_GGM(Path);
Long_ggm = Long_ggm' ;
lat_ggm = lat_ggm' ;
height_anom_ggm = height_anom_ggm' ;
gravity_anom_ggm = gravity_anom_ggm' ;
clear Long_ggm
clear lat_ggm
% compute reduced gravity anomaly
reduced_Grav_Anom = Free_Grav_Anom - gravity_anom_ggm ;

%compute orthometric height
ortho_Height = elevation - height_anom_ggm ;

% computing atmospheric correction
atmospheric_correction = compute_atm_correction(ortho_Height) ;

% Computing Gravity anomaly after applying free air and atmospheric correction => Gravity Anomaly Smw Atm
Anomaly_smw_atm = reduced_Grav_Anom - atmospheric_correction ;

% Plotting
Ask2 = input("Want to view the Scatter plots till Delta_g_smw_atm ? (Y/N):",'s' );
Ask2 = lower(Ask2);
if (Ask2 == 'y')
  % Plot
  printf('Showing Scatter plots\n') ;
  %Scatter plot for observed gravity
  P = 'Observed Gravity (in mGal)' ;
  U = 'in mGal';
  Scplot(P,longi, lati, obs_grav,U)
  % Scatter plot for elevation ( from ellipsoid)
  P = 'elevation (in m) (till flight height)' ;
  U = 'in meter' ;
  Scplot(P,longi, lati, elevation,U)
  % Scatter plot for normal gravity
  P = 'Normal Gravity for WGS84(in mGal)' ;
  U = 'in mGal';
  Scplot(P,longi,lati,gama,U);
  % Scatter plot for free air reduction
  P = 'Free air reduction (in mGal)' ;
  U = 'in mGal';
  Scplot(P,longi, lati, Free_Air_reduction,U)
  %Scatter plot for free air anomaly
  P = 'Free air Gravity anomaly (in mGal)' ;
  U = 'in mGal';
  Scplot(P,longi, lati, Free_Grav_Anom,U)
  %Scatter plot for gravity anomaly from GGM05C
  P = 'Gravity anomaly from GGM05C(in mGal)' ;
  U = 'in mGal';
  Scplot(P,longi, lati, gravity_anom_ggm,U)
  % Scatter plot for reduced gravity anomaly
  P = 'reduced gravity anomaly(in mGal)' ;
  U = 'in mGal';
  Scplot(P,longi, lati, reduced_Grav_Anom,U)
  % Scatter plot for geoid undulation from GGM05C
  P = 'Geoid undulation from GGM05C (in m)' ;
  U = 'in meter';
  Scplot(P,longi, lati,height_anom_ggm ,U)
  % Scatter plot for orthometric height
  P = 'Orthometric height (in m)' ;
  U = 'in meter';
  Scplot(P,longi, lati, ortho_Height,U)
  % Scatter plot for Atmospheric correction
  P = 'Atmospheric correction (in mGal)'
  U = 'in mGal' ;
  Scplot(P,longi, lati, atmospheric_correction,U) ;
  % scatter plot for Gravity anomaly after applying free air and atmospheric correction
  P = 'Gravity smw atm(in mGal)' ;
  U = 'in mGal';
  Scplot(P,longi, lati, Anomaly_smw_atm,U)
else
  printf('Continuining Without plotting\n') ;
endif
% Plotting
Ask3 = input("Want to view the interpolated heatmaps till Delta_g_smw_atm ? (Y/N):",'s' );
Ask3 = lower(Ask3);
if (Ask3 == 'y')
  % Plot
  printf('Showing heatmap plots\n') ;
  %heatmap plot for observed gravity
  P = 'Observed Gravity (in mGal)' ;
  U = 'in mGal';
  Plot_(P,longi, lati, obs_grav,U)
  % heatmap plot for elevation ( from ellipsoid)
  P = 'elevation (in m) (till flight height)' ;
  U = 'in meter' ;
  Plot_(P,longi, lati, elevation,U)
  % heatmap plot for normal gravity
  P = 'Normal Gravity for WGS84(in mGal)' ;
  U = 'in mGal';
  Plot_(P,longi,lati,gama,U);
  % heatmap plot for free air reduction
  P = 'Free air reduction (in mGal)' ;
  U = 'in mGal';
  Plot_(P,longi, lati, Free_Air_reduction,U)
  %heatmap plot for free air anomaly
  P = 'Free air Gravity anomaly (in mGal)' ;
  U = 'in mGal';
  Plot_(P,longi, lati, Free_Grav_Anom,U)
  %heatmap plot for gravity anomaly from GGM05C
  P = 'Gravity anomaly from GGM05C(in mGal)' ;
  U = 'in mGal';
  Plot_(P,longi, lati, gravity_anom_ggm,U)
  % heatmap plot for reduced gravity anomaly
  P = 'reduced gravity anomaly(in mGal)' ;
  U = 'in mGal';
  Plot_(P,longi, lati, reduced_Grav_Anom,U)
  % heatmap plot for geoid undulation from GGM05C
  P = 'Geoid undulation from GGM05C (in m)' ;
  U = 'in meter';
  Plot_(P,longi, lati,height_anom_ggm ,U)
  % heatmap plot for orthometric height
  P = 'Orthometric height (in m)' ;
  U = 'in meter';
  Plot_(P,longi, lati, ortho_Height,U)
  % heatmap plot for Atmospheric correction
  P = 'Atmospheric correction (in mGal)' ;
  U = 'in mGal' ;
  Plot_(P,longi, lati, atmospheric_correction,U) ;
  % heatmap plot for Gravity anomaly after applying free air and atmospheric correction
  P = 'Gravity smw atm(in mGal)' ;
  U = 'in mGal';
  Plot_(P,longi, lati, Anomaly_smw_atm,U)
else
  printf('Continuining Without heatmap plotting\n') ;
endif
% Step 6 Creating the GRID
[longs, lats, dg_smw_atm] = create_grid(Anomaly_smw_atm, 100, lati, longi);

% Apply gravimetric terrain reduction
Min_Lat = min(lati) - 0.5 ;
Max_Lat = max(lati) + 0.5 ;
Min_Long = min(longi) -0.5 ;
Max_Long = max(longi)  + 0.5 ;

% Import the SRTM DEM data
Ask4 = input("Do you want to provide the path of merged DEM data for the GGM05C Dataset(otherwise continue with sample one)? (Y/N) :",'s') ;
Ask4 = lower(Ask4) ;
if (Ask4 == 'y')
  File_Name = input('Provide the path for the DEM data file: ') ;
else
  File_Name = 'D:\IITK_Academics\4th Year\CE678A\Term_paper_CE678A\Data_678_TermPaper\Octave_Code_and_supporting_Files\merged_texas_dem.tif' ;
endif
Heights = imread(File_Name); % Reading DEM file
% Show the DEM Data
lat_dem = linspace(Min_Lat, Max_Lat, 100);  % Defining the latitude range taking a buffer of 0.5 degree
lon_dem = linspace(Min_Long, Max_Long, 100);  % Defining the longitude range taking a buffer of 0.5 degree
[X_dem, Y_dem] = meshgrid(lon_dem, lat_dem);

I = floor(linspace(1,14401,100));
J = floor(linspace(1,25201,100));
H_dem = double(Heights(I,J));
%Plotting the DEM
P= 'SRTM DEM';
U = 'in meters';
Plot_(P,lon_dem,lat_dem,H_dem,U)

% Terrain correction
TC = Terrain_Correction(X_dem, Y_dem, H_dem,1); %m/s2
figure;
pcolor(longs, lats, TC)
shading interp; % Interpolate colors for a smooth map
colorbar; % Add a colorbar to indicate the values of P
title(['Map of Terrain correction(in mGal) with respect to Longitude and Latitude']);
xlabel('Longitude (in degrees)');
ylabel('Latitude(in degrees)');
colormap('jet');
cbar = colorbar ;
units = 'mGal' ;
title(cbar, units);
% Faye anomaly
Anom_Faye = dg_smw_atm - TC ;
figure;
pcolor(longs, lats, Anom_Faye)
shading interp; % Interpolate colors for a smooth map
colorbar; % Add a colorbar to indicate the values of P
title(['Map of Faye Anomaly(in mGal) with respect to Longitude and Latitude']);
xlabel('Longitude (in degrees)');
ylabel('Latitude(in degrees)');
colormap('jet');
cbar = colorbar ;
units = 'mGal' ;
title(cbar, units);

% Tr
T_r = stokes_integral(longs, lats, Anom_Faye,'WGS84',1) ;
figure;
pcolor(longs, lats, T_r)
shading interp; % Interpolate colors for a smooth map
colorbar; % Add a colorbar to indicate the values of P
title(['Map of Disturbing potential(in m2/s2) with respect to Longitude and Latitude']);
xlabel('Longitude (in degrees)');
ylabel('Latitude(in degrees)');
colormap('jet');
cbar = colorbar ;
units = 'm2/s2' ;
title(cbar, units);

% Nr  = Tr./ gama;
Gama = compute_normal_gravity_84(lats); % in m/s2
Gama = Gama./(10^5) ; % for m/s2
N_r = (T_r)./(Gama) ;
##imagesc(N_r)
P = 'Undulation in m' ;
U = 'in m';
Plot_(P,lon_dem, lat_dem,N_r,U) ;
%
figure;
pcolor(longs, lats, N_r)
shading interp; % Interpolate colors for a smooth map
colorbar; % Add a colorbar to indicate the values of P
title(['Map of Short wave geoid undulation(in m) with respect to Longitude and Latitude']);
xlabel('Longitude (in degrees)');
ylabel('Latitude(in degrees)');
colormap('jet');
cbar = colorbar ;
units = 'm' ;
title(cbar, units);

Height_anom_ggm = linspace(min(height_anom_ggm),max(height_anom_ggm),100) ;
Height_anom_ggm_grid = meshgrid(Height_anom_ggm,Height_anom_ggm) ;
% Adding long wavelength geoid undulation effect
N_l = N_r + Height_anom_ggm_grid ;
figure;
pcolor(longs, lats, N_l)
shading interp; % Interpolate colors for a smooth map
colorbar; % Add a colorbar to indicate the values of P
title(['Map of geoid undulation(in m) with respect to Longitude and Latitude']);
xlabel('Longitude (in degrees)');
ylabel('Latitude(in degrees)');
colormap('jet');
cbar = colorbar ;
units = 'm' ;
title(cbar, units);

