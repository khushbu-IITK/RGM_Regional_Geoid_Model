function [X, Y, grid] = create_grid(mat, n, lat, lon)
  %Function for vector into a grid
  %INPUT -
  %1. mat - input vector
  %2. n - n number of points for which we use the lat & long points to get the resulting grid
  %3. lat - latitude data for the data point of input vector
  %4. lon - longitude data for the data point of input vector
  %OUTPUT -
  %   X - grid containing longitude of the corresponding to the output grid
  %   Y - grid containing latitude of the corresponding to the output grid
  %   grid - output converted grid of the input vector
  %EXAMPLE -
  %[lon, lat, Grav_Anom_smw_atm] = create_grid(anomaly_smw_atm, 1320, lat, lon);

  xmin = floor(min(lon)/0.1)*0.1 ;
  xmax = ceil(max(lon)/0.1)*0.1 ;
  ymin = floor(min(lat)/0.1)*0.1 ;
  ymax = ceil(max(lat)/0.1)*0.1 ;
  gridx = linspace(xmin, xmax,n) ;
  gridy = linspace(ymin,ymax,n);
##  gridx = [xmin:n:xmax]; % longitude grid n
##  gridy = [ymin:n:ymax]; % latitude grid n
  [X, Y] = meshgrid(gridx, gridy);
##  %SX = size(X)
  long = [] ;
  lati = [];
  var = [];
  S = floor(length(mat)/ n) ;
  for i = 1:S:length(mat)
    long(end +1) = lon(i) ;
    lati(end +1) = lat(i);
    var(end +1) = mat(i);
  endfor

##  S = size(long)
  grid = griddata (long,lati,var,X,Y, 'v4');
endfunction
