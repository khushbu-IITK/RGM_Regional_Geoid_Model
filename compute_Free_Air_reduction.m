function Free_Air_Reduction = compute_Free_Air_reduction(height) %, observed_gravity)
  % Function for computing free air reduction as per section 3.3 in haffman book for physical geodesy.
  % INPUT-
  % height (double) - (meters) Orthometric height / ellipsoidal height data
  % observed_gravity (double) - (mGal) Observed gravity data
  %OUTPUT -
  % Free_Air_Reduction (double) - (mGal) Free air reduction (considering free air)

  %Free_Air_Reduction = observed_gravity + 0.3086*height ;
  Free_Air_Reduction = 0.3086*height ;
end
