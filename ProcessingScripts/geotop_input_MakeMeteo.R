## geotop_input_MakeMeteo.R
#' This script is intended to make meteo input data at a constant timestep.

rm(list=ls())

# git directory for relative paths
git.dir <- "C:/Users/Sam/WorkGits/geotop_discharge/"

require(lubridate)
require(ggplot2)
require(dplyr)

# filenames
fname.out<- paste0(git.dir, "meteo/meteo0001.txt")

# datetime to start/end hourly data
POSIX.start <- ymd_hm("2010-01-01 00:00")
POSIX.end <- ymd_hm("2010-01-05 23:00")

# sequence
POSIX <- seq(POSIX.start, POSIX.end, by="30 min")

# make data frame
df.out <- data.frame(POSIX = format(POSIX, "%d/%m/%Y %H:%M"),
                             Iprec = 10,
                             WindSp = 1.0,
                             AirT = 20.0,
                             RH = 50.0,
                             Swglob = 400.0,
                             CloudTrans = 1.0)

# write output
f.out <- file(fname.out, open="wb")
write.table(df.out, file=f.out, quote=F, sep=",", na="-9999.0", row.names=F, eol="\n")
close(f.out)
