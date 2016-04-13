# Baidu Search Marketing Service

This gem is an easy-to-use, thin wrapper around the Baidu Search Marketing Service SOAP API v3.

This gem does not support the v4 JSON API or the BulkJobService.

## Installation

    gem install baidu-sms

## Usage

Each service is initialized with a hash with three symbol keys:

    credentials = {
      username: 'username',
      password: 'password',
      token: 'apitoken'
    }

There are three implemented services: ReportService, AdgroupService, and KeywordService.

    service = BaiduSMS::ReportService.new(credentials)
    service = BaiduSMS::AdgroupService.new(credentials)
    service = BaiduSMS::KeywordService.new(credentials)
    

### Using the ReportService

When you create a report, you'll get an ID:

    params = {
      performanceData: %w[cost cpc click impression ctr cpm conversion],
      startDate: Date.today - 1,
      endDate: Date.today - 1,
      levelOfDetails: BaiduSMS::LevelOfDetails::ACCOUNT
    }
    
    id = service.create_report(BaiduSMS::Reports::ACCOUNTS, params)

You can reference report type and level of detail by module constant or by name:

    BaiduSMS::Reports.from_name('accounts')
    # equals 
    BaiduSMS::Reports::ACCOUNTS
    
    # and
    
    BaiduSMS::LevelOfDetails::ACCOUNT
    # equals
    BaiduSMS::LevelOfDetails.from_name('account')

You need to poll to discover if the report is ready yet:

    if service.report_ready?(id)

Once the report is ready, you can get the URL where the report can be downloaded from:

    service.report_url(id) if service.report_ready?(id)

You can download the report from this URL.

### Using the other services

These services are synchronous; calling them will return results without having to poll.
Look at the methods in these classes to see the return types and how to call them.

## Tests

The services have tests - to run them, you need to create a file called `credentials.yml` at the root
of the repository, with this format in YAML:

    :username: username
    :password: password
    :token: apitoken

You can then run the tests by running `rspec`.