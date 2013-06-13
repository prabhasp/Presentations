setwd("~/Code/Presentations/prabhas/energy-summaries/data/")
library(plyr)
education <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Education_661_ALL_FACILITY_INDICATORS.csv")
education <- subset(education, select=c("X_lga_id", "power_access", "mylga", "mylga_state", "mylga_zone",
               "grid_proximity", "power_sources.generator", "power_sources.solar"))
education <- rename(education,c("X_lga_id" = "lga_id", "mylga"="lga", "mylga_state"="state", "mylga_zone"="zone", "power_access"="functional"))
education$sector <- "EDUCATION"

write.csv(education, "EducationElectricityData.csv")


health <- read.csv("~/Dropbox/Nigeria/Nigeria 661 Baseline Data Cleaning/in_process_data/nmis/Health_661_ALL_FACILITY_INDICATORS.csv")
health <- subset(health, select=c("X_lga_id", "power_access_and_functional", "mylga", "mylga_state", "mylga_zone",
           "not_for_private_1.grid_proximity", "health$not_for_private_1.power_sources.generator",
            "health$not_for_private_1.power_sources.solar"))
health <- rename(health,c("X_lga_id" = "lga_id", "mylga"="lga", "mylga_state"="state", "mylga_zone"="zone", 
                          "not_for_private_1.grid_proximity"="grid_proximity", "power_access_and_functional"="functional"))
health$sector <- "HEALTH"
write.csv(health, "HealthElectricityData.csv")