## geotop_input_MakeSoilColumn.R
#' This script is intended to  create a soil input file for simulations
#' in GEOtop. The soil column will have layers of uniform thickness.

rm(list=ls())

# git directory for relative paths
git.dir <- "C:/Users/Sam/WorkGits/geotop_discharge/"

# path to save output soil file
out.path <- paste0(git.dir, "soil/soil0001.txt")

# define soil layer properties
Dz   <- 10     # [mm] - thickness of organic soil layers
total.Dz <- 5000   # [mm] - total soil thickness
nsoilay  <- 50     # number of soil layers

# mineral soil - using values from Carsel & Parrish (1988) for loam
Ks <- 2.8889E-03     # [mm/s] - saturated hydraulic condutivity 
vwc_s <- 0.43        # [m3/m3] - saturated water content
vwc_r <- 0.078       # [m3/m3] - residual water content
VG_alpha <- 0.0036   # [mm-1] - Van Genuchten alpha (convert from 12.7 m-1)
VG_n <- 1.56         # [-] - Van Genuchten n

## figure out increment to increase mineral soil layer thickness with depth
# coefficient for incrementing
incrcoeff <- 0.0
for (j in 1:(nsoilay-1)){
  # figure out total increment coefficient
  incrcoeff <- incrcoeff + j
}

# incrementing constant
incconst <- (total.Dz - Dz*nsoilay)/incrcoeff

## build soil layers
df.out <- data.frame(Dz = numeric(length=nsoilay),
                     z.tot = NaN,
                     Kh = NaN,
                     Kv = NaN,
                     vwc_r = NaN,
                     vwc_s = NaN,
                     VG_alpha = NaN,
                     VG_n = NaN)
df.out$Dz[1] <- Dz
df.out$z.tot[1] <- Dz
for (j in 1:(nsoilay-1)){
    # mineral soil
    df.out$Dz[j+1] <- Dz + j*incconst
    df.out$z.tot[j+1] <- df.out$z.tot[j] + df.out$Dz[j+1]
}

# homogeneous
df.out$Kh <- Ks
df.out$Kv <- Ks
df.out$vwc_r <- vwc_r
df.out$vwc_s <- vwc_s
df.out$VG_alpha <- VG_alpha
df.out$VG_n <- VG_n

# save output file
write.csv(df.out, out.path, quote=F, row.names=F)