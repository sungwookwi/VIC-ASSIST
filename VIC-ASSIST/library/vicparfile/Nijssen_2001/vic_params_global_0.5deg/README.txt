VIC Global Input Parameters
0.5-Degree Resolution

These parameters are a higher-resolution update (by Jenny Adam) of the earlier 2-degree global parameters developed by Nijssen et al. (2001a,b). The source datasets were the same as in the original Nijssen et al. (2001b) parameter sets (namely, the AVHRR-derived landcover dataset of Hansen et al. (2000) and the soil textures of FAO (1995)). No new calibrations were performed, so calibration parameters (b_infilt, baseflow parameters, and soil layer thicknesses) were simply sub-sampled from Nijssen et al. (2001b) to 0.5 degree resolution via a nearest-neighbor approach.

The set of parameter files includes:

 * global_soil_param_new - Soil parameter file.  Note, the baseflow parameters in this file are the NIJSSEN2001 parameters d1-d4 instead of the ARNO parameters. To use this file, you must set the BASEFLOW flag to "NIJSSEN2001" in your global parameter file.
 * world_veg_lib.txt - Vegetation library file
 * global_veg_param_new - Vegetation parameter file
 * global_snowbands_new - Snowbands file 
