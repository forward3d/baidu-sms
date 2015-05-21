require_relative '../../lib/baidu-sms'

RSpec.describe BaiduSMS::ReportService do
  
  before(:all) do
    yml = YAML.load_file(File.expand_path("../../../credentials.yml", __FILE__)) # create this if you want to test!
    @service = BaiduSMS::ReportService.new(yml)
    @params = {
      performanceData: %w[cost cpc click impression ctr cpm conversion],
      startDate: (Date.today - 1).strftime("%FT%T"),
      endDate: (Date.today - 1).strftime("%FT%T"),
      levelOfDetails: BaiduSMS::LevelOfDetails::ACCOUNT
    }
  end
  
  it "can create a report without error" do
    expect {
      id = @service.create_report(BaiduSMS::Reports::ACCOUNTS, @params)
    }.to_not raise_error
  end
  
  it "can create a report and get a report ID" do
    id = @service.create_report(BaiduSMS::Reports::ACCOUNTS, @params)
    expect(id).to match(/^[a-f0-9]{32}$/)
  end
  
  it "can retrieve a report's status" do
    id = @service.create_report(BaiduSMS::Reports::ACCOUNTS, @params)
    expect(@service.report_ready?(id)).to eq(true).or eq(false)
  end
  
  it "can get a report URL" do
    id = @service.create_report(BaiduSMS::Reports::ACCOUNTS, @params)
    loop do
      if @service.report_ready?(id)
        break
      else
        sleep 5
      end
    end
  end
  
end