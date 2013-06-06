library(RJSONIO)

setwd("~/Code/Presentations/prabhas/kigali-mopup-presentation/")
nmis_matches <- do.call(rbind.data.frame, fromJSON("data/baseline_compeltion.json"))
flis_matches <- do.call(rbind.data.frame, fromJSON("data/facility_list_completion.json"))

#nmis_matches <- subset(nmis_matches, select=c("zone", "state", "lga", "lga_id", "total", "edu_total", "health_total"))
all_matched <- merge(flis_matches, nmis_matches, by="lga_id", suffixes=c("_facility_list", "_baseline"))
write.csv(all_matched, "data/all_matched_data.csv")

