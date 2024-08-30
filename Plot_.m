function Plot_(Param,long,lat,var,units)
  % Plots the heatmaps for the variable, for given latitude and longitude. only for 1000 points, which are equally spaced.
  %INPUT -
  %1. Param (String) - provide the general terminology for variable for which plotting the scatter plot.
  %2. long (double) - (degrees) longitude used for plot.
  %3. lat (double) - (degrees) latitude used for plot.
  %4. units (string) - For providing unit for the colorbar.
  %OUTPUT -
  %Plots the heatmap

  % Create a grid of points using meshgrid
  n = 1000;
  [Xgrid, Ygrid] = meshgrid(linspace(min(long),max(long),n), linspace(min(lat),max(lat),n));
  %[Xgrid, Ygrid] = meshgrid(unique(long(1:800:end)), unique(lat(1:800:end)));
  Pgrid = griddata(long, lat, var, Xgrid, Ygrid, "linear"); % Interpolate var values onto the grid
  % Create the pcolor plot
    figure('position', get(0,'screensize'));
  pcolor(Xgrid, Ygrid, Pgrid);
  shading interp; % Interpolate colors for a smooth map
  colorbar; % Add a colorbar to indicate the values of P
  title(['Map of ' Param ' with respect to Longitude and Latitude']);
  xlabel('Longitude (in degrees)');
  ylabel('Latitude(in degrees)');
  colormap('jet');
  cbar = colorbar ;
  title(cbar, units);
end
