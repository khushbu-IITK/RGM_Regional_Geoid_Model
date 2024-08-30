function Scplot(Parameter, long, lat, var,units )
  % Plots the scatter plot for the variable, for given latitude and longitude.
  %INPUT -
  %1. Parameter (String) - provide the general terminology for variable for which plotting the scatter plot.
  %2. long (double) - (degrees) longitude used for plot.
  %3. lat (double) - (degrees) latitude used for plot.
  %4. units (string) - For providing unit for the colorbar.
  %OUTPUT -
  %Plots the scatter plots

  figure('position', get(0,'screensize'));
  scatter(long,lat,5,var,'filled');
  xlabel('Longitude (in degrees)');
  ylabel('Latitude (in degrees)');
  title(['Scatter plot of ' Parameter]);
  colormap('jet');
  cbar = colorbar ;
  title(cbar, units);

end
