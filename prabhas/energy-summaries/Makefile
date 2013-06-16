BASE_DIR=~/Code/Presentations/prabhas
index.html: index.Rmd MakePresentation.R $(BASE_DIR)/NigeriaPresentationUtils.RData
	R CMD BATCH MakePresentation.R /dev/tty
$(BASE_DIR)/NigeriaPresentationUtils.RData: $(BASE_DIR)/NigeriaPresentationUtils.R
	cd $(BASE_DIR); R CMD BATCH NigeriaPresentationUtils.R /dev/tty
clean:
	rm cache/*
	touch index.Rmd
