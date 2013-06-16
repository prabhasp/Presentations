setwd("~/Code/Presentations/prabhas/energy-summaries/data/")
library(plyr)
library(stringr)
e6 <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Education_661_ALL_FACILITY_INDICATORS.csv")
e1 <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Education_113_ALL_FACILITY_INDICATORS.csv")
ep <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Education_Pilot_ALL_FACILITY_INDICATORS.csv")
e6 <- subset(e6, select=c("X_lga_id", "power_access",
                          "power_sources.grid", "power_sources.generator", "power_sources.solar_system", 
                          "generator_funct_yn", "solar_funct_yn", "grid_funct_yn"))
e1 <- subset(e1, select=c("X_lga_id", "power_access",
                          "power_grid_connection", "power_generator", "power_solar_system",
                          "generator_funct_yn", "solar_funct_yn", "grid_funct_yn"))
ep[,c('power_access', 'generator_funct_yn', 'solar_funct_yn', 'grid_funct_yn')] <- NA
ep <- subset(ep, select=c("X_lga_id", "power_access",
                          "power_grid_connection", "power_generator", "power_solar_system",
                          "generator_funct_yn", "solar_funct_yn", "grid_funct_yn"))
ep$gps_lat <- str_extract()
### WARNING: MAKE SURE ORDER IS THE SAME!
std_names <- c("lga_id", "functional_power", "grid", "genset", "solar",
               "generator_functional", "solar_functional", "grid_functional")
names(e1) <- std_names
names(e6) <- std_names
names(ep) <- std_names
education <- rbind(e1, e6, ep)
education$sector <- "EDUCATION"

write.csv(education, "EducationElectricityData.csv", row.names=F)


h6 <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Health_661_ALL_FACILITY_INDICATORS.csv")
h1 <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Health_113_ALL_FACILITY_INDICATORS.csv")
hp <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Health_Pilot_ALL_FACILITY_INDICATORS.csv")
names(h6) <- str_replace(names(h6), "not_for_private_[0-9].", "")
h6 <- subset(h6, select=c("X_lga_id", "power_access_and_functional",
                          "power_sources.grid", "power_sources.generator", "power_sources.solar", 
                          "generator_funct_yn", "solar_funct_yn", "grid_funct_yn"))
h1 <- subset(h1, select=c("X_lga_id", "power_access_and_functional",
                          "power_sources_grid", "power_sources_generator", "power_sources_solar",
                          "generator_funct_yn", "solar_funct_yn", "grid_funct_yn"))
hp <- subset(hp, select=c("X_lga_id", "power_access_and_functional",
                          "power_sources_grid", "power_sources_generator", "power_sources_solar",
                          "generator_funct_yn", "solar_funct_yn", "grid_funct_yn"))
### WARNING: WATCH THE ORDER!
std_names <- c("lga_id", "functional_power", "grid", "genset", "solar",
               "generator_functional", "solar_functional", "grid_functional")
names(h1) <- std_names
names(h6) <- std_names
names(hp) <- std_names
health <- rbind(h1, hp, h6)
health$sector <- "HEALTH"
write.csv(health, "HealthElectricityData.csv", row.names=F)
