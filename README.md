# Baidu Searach Marketing Service

Initialize service

	service = BaiduSMS::ReportService.new({})

Create report and get it's ID

	params = {performanceData: %w[cost cpc click impression ctr cpm conversion],
	          startDate: (Date.today - 1).strftime("%FT%T"),
	          endDate: (Date.today - 1).strftime("%FT%T"),
	          levelOfDetails: BaiduSMS::LevelOfDetails::ACCOUNT}

	id = service.create_report(BaiduSMS::Reports::ACCOUNTS, params)

You can reference report type and level of detail by module constant or by name

	BaiduSMS::Reports.from_name('accounts')
	# equals 
	BaiduSMS::Reports::ACCOUNTS
	
	# and
	
	BaiduSMS::LevelOfDetails::ACCOUNT
	# equals
	BaiduSMS::LevelOfDetails.from_name('account')

Get report URL by report ID if ready

	service.report_url(id) if service.report_ready?(id)

Download report and be done