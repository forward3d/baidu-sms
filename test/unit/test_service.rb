require_relative "../test_helper"

class TestReportHelper < Test::Unit::TestCase

  def setup
    yml = YAML.load_file(File.join(File.dirname(File.expand_path(__FILE__)), "credentials.yml")) # create this if you want to test!
    @service = BaiduSMS::ReportService.new(yml)
  end
    
  def test_scheduling_report
    params = {performanceData: %w[cost cpc click impression ctr cpm conversion],
              startDate: (Date.today - 1).strftime("%FT%T"),
              endDate: (Date.today - 1).strftime("%FT%T"),
              levelOfDetails: BaiduSMS::LevelOfDetails::ACCOUNT}
    
    id = @service.create_report(BaiduSMS::Reports::ACCOUNTS, params)
    assert_match /^[a-f0-9]{32}$/, id
    puts id
  end
  

  def test_gets_report_state
    assert_raise(BaiduSMS::ReportService::BaiduSMSInvalidRequestError) { @service.report_ready?("xxxxxxxxxxx") }
    
    puts @service.report_ready?("...") # get parameter from create_report
  end

  def test_gets_url
    assert_raise(BaiduSMS::ReportService::BaiduSMSInvalidRequestError) { @service.report_url("xxxxxxxxxxx") }
  
    puts @service.report_url("...") # get parameter from create_report
  end
  
end
