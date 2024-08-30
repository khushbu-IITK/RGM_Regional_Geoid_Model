function [lati, longi, elevation, obs_grav] = Extract_Data (filename)
  % Function for reading GGM elevation and gravity anomaly data
  %INPUT -
  %1. filename (string) - path to GRAV-D file containing observed graity data
  %OUTPUT -
  %   longi (double) - (degree) Longitudes of the GGM data points
  %   lati (double) - (degree) Latitude of the GGM data points
  %   elevation (double) - (meters) Flight elevation for each data point
  %   obs_grav (double) - gravity_anomaly_ggm  - (mGal) Observed gravity data

  % Opening the file
  fid = fopen (filename, "r");

  % Reading data into a matrix
  data = textscan (fid,'CS06%d%d%f%f%f%f\n','Delimiter',' ','MultipleDelimsAsOne',1, 'CommentStyle', '/');
  fclose(fid);
  lines = [data(1){:}];
  datas = cell2mat(cellfun(@double, data(2:end), 'uni', false));

  lati = datas(:,2)';
  longi = datas(:,3)';
  elevation = datas(:,4)';
  obs_grav = datas(:,5)';
  endfunction
