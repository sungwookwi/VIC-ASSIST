#include <stdio.h>
#include <stdlib.h>

/* Prepared 8/2000 */
/* Create a VIC soil file with the LDAS soil hydraulic parameters */
/* Takes two input files:
   1. LDAS domain soil file
   2. file containing latitude and longitude for each grid cell
/* NOTE: soil files will be in the 53 column format of
   VIC 4.0 with 3 soil layers */

/* 

 The following parameters will require later calibration
   Ds
   Dsmax
   Ws
   b_infilt
   soil_depth[0]
   soil_depth[1]
   soil_depth[2]

 The following parameters will need to be revised based on the
 meteorological forcing data
   annual_prec
   avg_temp

*/

#define BUF_SIZE   1024
#define MAX_LAYERS    3
#define VOID -99.

/* define the soil struct - stripped down version of the one in VIC
   with only those variables in soil file defined */
typedef struct {
  int      ACTIVE;                    /* TRUE compute cell */
  int      FS_ACTIVE;                 /* TRUE froz soil alg active in current cell */
  float    Ds;                        /* fraction of max subsurface flow rate */
  float    Dsmax;                     /* max subsurface flow rate (mm/day) */
  float    Ksat[MAX_LAYERS];          /* Ksat(mm/day) */
  float    Wcr[MAX_LAYERS];           /* critical moisture level (mm)*/
  float    Wpwp[MAX_LAYERS];          /* permanent wilting point (mm) */
  float    Ws;                        /* fraction of maximum soil moisture */
  float    annual_prec;               /* annual average precipitation (mm) */
  float    avg_temp;                  /* average soil temperature (C) */
  float    b_infilt;                  /* infiltration parameter */
  float    bulk_density[MAX_LAYERS];  /* soil bulk density (kg/m^3) */
  float    c;                         /* exponent */
  float    depth[MAX_LAYERS];         /* thickness of each soil moisture layer (m)*/
  float    dp;                        /* soil thermal damping depth (m) */
  float    expt[MAX_LAYERS];          /* pore-size distribution per layer */
  float    init_moist[MAX_LAYERS];    /* initial layer moisture level (mm) */
  float    porosity[MAX_LAYERS];      /* porosity (fraction) */
  float    quartz[MAX_LAYERS];        /* quartz content of soil (fraction) */
  float    resid_moist[MAX_LAYERS];   /* residual moisture content of soil layer */
  float    rough;                     /* soil surface roughness (m) */
  float    snow_rough;                /* snow surface roughness (m) */
  float    soil_density[MAX_LAYERS];  /* soil partical density (kg/m^3) */
  float    elevation;                 /* grid cell elevation (m) */
  float    lat;                       /* grid cell central latitude */
  float    lng;                       /* grid cell central longitude */
  float    off_gmt;                   /* gmt offset */
  float    bubble[MAX_LAYERS];        /* bubble pressure in cm's */
  float    phi_s[MAX_LAYERS];         /* dummy place holder */
  int      gridcel;                   /* grid cell number */
} soil_con_struct;     

void usage();
void print_soil(soil_con_struct soil);
int  read_soil( soil_con_struct *soil, FILE *fp );

int main( int argc, char *argv[] )
{

  FILE *fpglb;
  FILE *fpbas;

  soil_con_struct *soil_global;

  float basin_lat, basin_lon;
  int rec=0;
  int i;
  char str[BUF_SIZE+1];

  if(argc!=3)
    usage();
  
  if( !(fpglb=fopen(argv[1],"r")) ){
    fprintf(stderr,"Cannot open global soilfile:\t%s\n",argv[1]);
    exit(EXIT_FAILURE);
  }

  if( !(fpbas=fopen(argv[2],"r")) ){
    fprintf(stderr,"Cannot open basin soilfile:\t%s\n",argv[2]);
    exit(EXIT_FAILURE);
  }

  /* read the global soil file cells into memory */
  while(fgets(str,BUF_SIZE,fpglb)){
    rec++;
  }
  fprintf(stderr,"Number of records:\t%d\n", rec);

  if( !(soil_global = malloc(sizeof(soil_con_struct)*rec)) ){
    fprintf(stderr,"Cannot allocate memory\n");
    exit(EXIT_FAILURE);
  }
  /* read global file into memory */
  rewind(fpglb);
  for(i=0;i<rec;i++)
    read_soil(&soil_global[i],fpglb);

  /* read basin lat/long file one line at a time*/
  while(fscanf(fpbas,"%f %f",&basin_lat,&basin_lon) == 2){
    for(i=0;i<=rec;i++){
      if(rec==i){
	fprintf(stderr,"Cannot find a match for location:\t%f %f\n",
		basin_lat, basin_lon);
	exit(EXIT_FAILURE);
      }
      if(basin_lat==soil_global[i].lat &&
	 basin_lon==soil_global[i].lng){
	print_soil(soil_global[i]);
	break;
      }
    }
  }

  return(EXIT_SUCCESS);
}
/**********************************************************/
void usage()
{
  fprintf(stderr,"USAGE:\trevise_parameters <input global soil file> <basin lat/long file>\n");
  exit(EXIT_FAILURE);
}
/**********************************************************/
void print_soil( soil_con_struct soil )
{

  int layer;

  fprintf(stdout, "%d %d %.4f %.4f ", soil.ACTIVE, soil.gridcel, soil.lat,  soil.lng);

  /* infiltration parameter */
  fprintf(stdout, "%.4f ", soil.b_infilt);

  /* fraction of baseflow rate */
  fprintf(stdout, "%.4f ", soil.Ds);

  /* maximum baseflow rate */
  fprintf(stdout, "%.4f ", soil.Dsmax);

  /* fraction of bottom soil layer moisture */
  fprintf(stdout, "%.4f ", soil.Ws);

  /* exponential */
  fprintf(stdout, "%.1f ", soil.c);

  /* expt for each layer */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.3f ", soil.expt[layer]);

  /* layer saturated hydraulic conductivity */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.3f ", soil.Ksat[layer]);

  /* read layer phi_s */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.4f ", soil.phi_s[layer]);

  /* read layer initial moisture */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.3f ", soil.init_moist[layer]);

  /* read cell mean elevation */
  fprintf(stdout, "%.2f ", soil.elevation);

  /* soil layer thicknesses */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.2f ", soil.depth[layer]);

  /* average soil temperature */
  fprintf(stdout, "%.3f ", soil.avg_temp);

  /* soil damping depth */
  fprintf(stdout, "%.1f ", soil.dp);

  /* layer bubbling pressure */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.3f ", soil.bubble[layer]);

  /* layer quartz content */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.3f ", soil.quartz[layer]);       
  /* layer bulk density */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.2f ", soil.bulk_density[layer]);

  /* layer soil density */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.2f ", soil.soil_density[layer]);

  /* cell gmt offset */
  fprintf(stdout, "%.0f ", soil.off_gmt);

  /* layer critical point */
  for(layer=0;layer<MAX_LAYERS;layer++)
    fprintf(stdout, "%.3f ", soil.Wcr[layer]);

  /* layer wilting point */
  for(layer=0;layer<MAX_LAYERS;layer++)
    fprintf(stdout, "%.3f ", soil.Wpwp[layer]);

  /* soil roughness */
  fprintf(stdout, "%.3f ", soil.rough);

  /* snow roughness */
  fprintf(stdout, "%.3f ", soil.snow_rough);

  /* cell annual precipitation */
  fprintf(stdout, "%.2f ", soil.annual_prec);

  /* layer residual moisture content */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fprintf(stdout, "%.3f ", soil.resid_moist[layer]);

  /* frozen soil active flag */
  fprintf(stdout, "%d", soil.FS_ACTIVE);

  fprintf(stdout, "\n");               

}
/**********************************************************/
int read_soil( soil_con_struct *soil, FILE *fp )
{
  /* Reads LDAS soil file for entire domain */

  int layer;

  if( fscanf(fp, "%d %d %f %f ",
             &soil->ACTIVE, &soil->gridcel, &soil->lat,  &soil->lng) == EOF )
    return 0;

  /* infiltration parameter */
  fscanf(fp, "%f ", &soil->b_infilt);

  /* fraction of baseflow rate */
  fscanf(fp, "%f ", &soil->Ds);

  /* maximum baseflow rate */
  fscanf(fp, "%f ", &soil->Dsmax);

  /* fraction of bottom soil layer moisture */
  fscanf(fp, "%f ", &soil->Ws);

  /* exponential */
  fscanf(fp, "%f ", &soil->c);

  /* expt for each layer */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->expt[layer]);

  /* layer saturated hydraulic conductivity */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->Ksat[layer]);

  /* read layer phi_s */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->phi_s[layer]);

  /* read layer initial moisture */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->init_moist[layer]);

  /* read cell mean elevation */
  fscanf(fp, "%f ", &soil->elevation);

  /* soil layer thicknesses */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->depth[layer]);

  /* average soil temperature */
  fscanf(fp, "%f ", &soil->avg_temp);

  /* soil damping depth */
  fscanf(fp, "%f ", &soil->dp);

  /* layer bubbling pressure */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->bubble[layer]);

  /* layer quartz content */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->quartz[layer]);       
  /* layer bulk density */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->bulk_density[layer]);

  /* layer soil density */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->soil_density[layer]);

  /* cell gmt offset */
  fscanf(fp, "%f ", &soil->off_gmt);

  /* layer critical point */
  for(layer=0;layer<MAX_LAYERS;layer++)
    fscanf(fp, "%f ", &soil->Wcr[layer]);

  /* layer wilting point */
  for(layer=0;layer<MAX_LAYERS;layer++)
    fscanf(fp, "%f ", &soil->Wpwp[layer]);

  /* soil roughness */
  fscanf(fp, "%f ", &soil->rough);

  /* snow roughness */
  fscanf(fp, "%f ", &soil->snow_rough);

  /* cell annual precipitation */
  fscanf(fp, "%f ", &soil->annual_prec);

  /* layer residual moisture content */
  for(layer = 0; layer < MAX_LAYERS; layer++)
    fscanf(fp, "%f ", &soil->resid_moist[layer]);

  /* frozen soil active flag */
  fscanf(fp, "%d", &soil->FS_ACTIVE);

  return 1;
}
