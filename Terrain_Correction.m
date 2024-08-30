function TC = Terrain_Correction(gridX, gridY, H_comb, res)
  %calculates gravimetric terrain reduction TC over given Latitude,Longitude grid with a given resolution
  %INPUT -
  %1. gridX (double) -(degrees) Latitude grid used for gfaye
  %2. gridY (double) -(degrees) Longitude grid used for gfaye
  %3. H_comb (double) -(meter) DEM grid with elevations
  %4. res (double) -(degrees) Grid resolution
  %OUTPUT -
  %   TC (double) - (mGal) gravimetric terrain reduction

  Longm=gridX;
  Latm=gridY;
  Mlat=mean(mean(Latm)) ;
  Mlong = mean(mean(Longm));
  r3=(sqrt((Longm- Mlong).^2+(Latm-Mlat).^2)).^3;
  ##disp(max(max(r3))) ;
  %figure ;
  %scatter(Longm,Latm,r3)
  r3_inv=1./r3;
  r3_inv(r3<111319.9*res)=100;

  clear Longm Latm;


  FR=fft2(r3_inv);
  %FFRR = length(FR)
  FH2=fft2(H_comb.^2);
  FH=fft2(H_comb);
  F1=fft2(ones(size(FH)));

  TCterm1 = (H_comb.^2).*ifft2(F1.*FR);
  TCterm3 =  -2*H_comb.*ifft2(FH.*FR);
  TCterm2 = ifft2(FH2.*FR);
  c = ((10^(-5))*2.67*6.6720*(10^(-8))/2);
  % delx = 111319.9*cosd(Mlat)*res;
  % dely = 111319.9*res;
  TC=real(c*(TCterm1+TCterm2+TCterm3)) ; %%*((res*(pi/180))^2);
endfunction
