## @knitr expternal-code

library(stringr)
library(plyr)
library(ggplot2)
library(scales)

# ONLY FUNCTIONS IN THIS FILE... OTHERWISE IT LEADS SLOW

lganamesdump = function(df1, lgacolname="lga", statecolname="state") {
  d_ply(df1, c(statecolname), function (df) {
    print(strwrap(str_c(toupper(df[1,statecolname]), ": ", 
                  str_c(tolower(df[,lgacolname]), collapse=", ")), 90))
  })
}

library(rgeos)
library(maptools)
library(scales)

lgashp <- readShapeSpatial('~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/raw_data/nga_lgas/nga_lgas.shp')
lgas <- fortify(lgashp, region="lga_id")
stateshp <- readShapeSpatial('~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/raw_data/nga_states/nga_states.shp')
states <- fortify(stateshp)

state_overlay <- function() {
  stateCentroids <- data.frame(gCentroid(stateshp, byid=T))
  stateCentroids$SID <- row.names(stateCentroids)
  stateshpd <- data.frame(stateshp, SID=getSpPPolygonsIDSlots(stateshp) )
  stateCenters <- merge(stateCentroids, stateshpd, by="SID")
  stateCenters <- rename(stateCenters, c("Name"="STATE"))
  stateCenters
}
stateCenters <- state_overlay()

lga_map = function(geom_map_thingy) {
  ggplot() + geom_map_thingy + expand_limits(x=lgas$long, y=lgas$lat) +
    theme(axis.title=element_blank(), axis.text=element_blank(),
          axis.ticks = element_blank(), panel.grid=element_blank(), 
          panel.background=element_rect(fill='#888888'),
          legend.position = "bottom") +
    geom_text(data=stateCenters, aes(x=x, y=y, label=STATE)) +
    geom_map(data=states, aes(map_id=id), fill="transparent", color='#444444', map=states) +
    scale_fill_brewer(type="seq", palette=2)
}

ratioToPct <- function(numvec, round.digits=0) {
    paste0(round(numvec * 100, round.digits), "%")
}

flipAndPrint <- function(df) {
  df <- data.frame(t(df))
  names(df) <- unlist(df[1,])
  df[-1,]
}