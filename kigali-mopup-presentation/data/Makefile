all_matched_data.csv: JsonDataToCsv.R baseline_completion.json facility_list_completion.json
	Rscript JsonDataToCsv.R
download:
	wget http://nmis.mdgs.gov.ng:3000/api/summaries/baseline/lga -O baseline_completion.json
	wget http://nmis.mdgs.gov.ng:3000/api/summaries/facility_list/lga -O facility_list_completion.json
	Rscript JsonDataToCsv.R
