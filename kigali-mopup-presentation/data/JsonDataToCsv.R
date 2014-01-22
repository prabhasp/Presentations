library(RJSONIO)

setwd("~/Code/Presentations/prabhas/kigali-mopup-presentation/")
nmis_matches <- do.call(rbind.data.frame, fromJSON("data/baseline_completion.json"))
flis_matches <- do.call(rbind.data.frame, fromJSON("data/facility_list_completion.json"))

# to calculate "off"
# all_matched <- merge(flis_matches, nmis_matches, by="lga_id", suffixes=c("_facility_list", "_baseline"))
# off <- subset(all_matched, subset=(matched_baseline == matched_facility_list), select=c("lga_id", "matched_baseline", "matched_facility_list"))
# write.csv(off, "data/off.csv", row.names=F)

nmis_matches <- subset(nmis_matches, select=c("zone", "state", "lga", "lga_id", "total", "edu_total",
                                              "health_total", "left"))
flis_matches <- subset(flis_matches, select=c("lga_id", "matched", "total", "edu_total", "health_total",
                                              "edu_matched", "health_matched", "left"))
all_matched <- merge(flis_matches, nmis_matches, by="lga_id", suffixes=c("_facility_list", "_baseline"),
                     all.x=T, all.y=T)
write.csv(all_matched, "data/all_matched_data.csv", row.names=F)