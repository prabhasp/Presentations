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

state_overlay <- function() {
  lgaCentroids <- gCentroid(lgashp, byid=T)
}

lga_map = function(geom_map_thingy) {
  ggplot() + geom_map_thingy + expand_limits(x=lgas$long, y=lgas$lat) +
    theme(axis.title=element_blank(), axis.text=element_blank(),
          axis.ticks = element_blank(), panel.grid=element_blank(), 
          panel.background=element_rect(fill='#888888'),
          legend.position = "bottom")
}

ratioToPct <- function(numvec, round.digits=0) {
    paste0(round(numvec * 100, round.digits), "%")
}

flipAndPrint <- function(df) {
  df <- data.frame(t(df))
  names(df) <- unlist(df[1,])
  df[-1,]
}