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

lga_map = function(geom_map_thingy, filltype="seq", nostatenames=FALSE) {
    
  ggplot() + geom_map_thingy + expand_limits(x=lgas$long, y=lgas$lat) +
    theme(axis.title=element_blank(), axis.text=element_blank(),
          axis.ticks = element_blank(), panel.grid=element_blank(), 
          panel.background=element_rect(fill='#888888'),
          legend.position = "bottom") +
          scale_fill_brewer(type=filltype, palette=2) +
          geom_map(data=states, aes(map_id=id), fill="transparent", color='#444444', map=states) +
    if (!nostatenames) {
      geom_text(data=stateCenters, aes(x=x, y=y, label=STATE))
    }
}

ratioToPct <- function(numvec, round.digits=0) {
    paste0(round(numvec * 100, round.digits), "%")
}

flipAndPrint <- function(df) {
  df <- data.frame(t(df))
  names(df) <- unlist(df[1,])
  df[-1,]
}

### Aggregation utils
icount <- function(predicate) { 
  counts <- table(predicate)
  if('TRUE' %in% names(counts)) { counts['TRUE'] }
  else { 0 }
}
ratio <- function(numerator_col, denominator_col, filter=TRUE) {
  df <- data.frame(cbind(num=numerator_col, den=denominator_col))
  df <- na.omit(df)
  df[filter,]
  sum(df$num) / sum(df$den)
}
bool_proportion_string <- function(numerator_TF, denominator_TF="yes") {
  if(!is.logical(numerator_TF))
    numerator_TF <- as.logical(recodeVar(as.character(numerator_TF), src=c("yes", "no"), tgt=c(TRUE, FALSE)))
  if(!is.logical(denominator_TF))
    denominator_TF <- as.logical(recodeVar(as.character(denominator_TF), src=c("yes", "no"), tgt=c(TRUE, FALSE)))
  bool_proportion(numerator_TF, denominator_TF)
}
bool_proportion <- function(numerator_TF, denominator_TF=TRUE) {
  df <- data.frame(cbind(num=numerator_TF, den=denominator_TF))
  df <- na.omit(df)
  icount((df$num & df$den)) / icount((df$den))
}
to_pct <- function(a) { a * 100 }