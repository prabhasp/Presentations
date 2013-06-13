DDDIR=~/Dropbox/Nigeria/Nigeria\ 661\ Baseline\ Data\ Cleaning/in_process_data/nmis
NMISEXT=_661_NMIS_Facility.csv
FULLEXT=_661_ALL_FACILITY_INDICATORS.csv
all: WaterWElectricity.csv EducationElectricityData.csv
WaterWElectricity.csv: $(DDDIR)/Water$(NMISEXT) MakeWaterData.R
	R CMD BATCH MakeWaterData.R /dev/tty
HealthElectricityData.csv EducationElectricityData.csv: $(DDDIR)/Education$(FULLEXT) MakeSectorData.R $(DDDIR)/Health$(FULLEXT)
	R CMD BATCH MakeSectorData.R /dev/tty
