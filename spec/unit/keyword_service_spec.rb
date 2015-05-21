require_relative '../../lib/baidu-sms'

RSpec.describe BaiduSMS::KeywordService do
  
  before(:all) do
    @yml = YAML.load_file(File.expand_path("../../../credentials.yml", __FILE__)) # create this if you want to test!
    @service = BaiduSMS::KeywordService.new(@yml)
  end
  
  it "can list keyword IDs" do
    adgroup_service = BaiduSMS::AdgroupService.new(@yml)
    adgroup_info = adgroup_service.get_all_adgroup_id
    adgroup_id = adgroup_info.first[:adgroup_ids].first
    keywords = @service.get_keyword_by_adgroup_id(adgroup_id)
    expect(keywords.size).to be > 0
    expect(keywords.class).to eq(Array)
  end
  
end