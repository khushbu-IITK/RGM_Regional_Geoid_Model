function [longi_ggm, lati_ggm, height_anom_ggm, gravity_anom_ggm] = Extract_GGM (path)
  % Function for reading GGM elevation and gravity anomaly data
  %INPUT -
  %   path (string) - Vector containing path to all the files containing GGM data
  %OUTPUT -
  %   longi_ggm (double) - (degree) Longitudes of the GGM data points
  %   lati_ggm (double) - (degree) Latitude of the GGM data points
  %   height_anom_ggm (double) - (meters) GGM height anomaly data
  %   gravity_anom_ggm (double) - (mGal) GGM gravity anomaly data

  i = 1;
  longi_ggm = [];
  lati_ggm = [];
  height_anom_ggm = [];
  gravity_anom_ggm = [];
  while i <= rows(path)
    fid = fopen (path(i,:), "r");
    Delim = {';'} ;
    ggm = textscan (fid,'%f%f%f%f%f%f',10033, 'Delimiter',Delim,'MultipleDelimsAsOne',1, 'HeaderLines',33) ;
    fclose(fid);
    lon_gg = [ggm(2){:}]; % longitude in degrees
    %Len = length(lon_gg)
    lat_gg = [ggm(3){:}]; % latitude in degrees
    height_anomaly_gg = [ggm(5){:}]; % meters
    gravity_anomaly_gg = [ggm(6){:}]; % mGal
    longi_ggm = [longi_ggm, lon_gg'];
    %length(longi_ggm)
    lati_ggm = [lati_ggm, lat_gg'];
    height_anom_ggm = [height_anom_ggm, height_anomaly_gg'];
    gravity_anom_ggm = [gravity_anom_ggm, gravity_anomaly_gg'];
    i = i+1;
  endwhile
endfunction
