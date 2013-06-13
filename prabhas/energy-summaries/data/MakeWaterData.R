setwd("~/Code/Presentations/prabhas/energy-summaries/data/")
library(plyr)
water <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Water_661_NMIS_Facility.csv")
water <- subset(water, select=c("X_lga_id", "lift_mechanism", "lga", "state", "zone"))
water <- rename(water,c("X_lga_id" = "lga_id"))
water$sector <- "WATER"

water_w_elec <- subset(water, lift_mechanism == "Electric")
write.csv(water_w_elec, "WaterWElectricity.csv")