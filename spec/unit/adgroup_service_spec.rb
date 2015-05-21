require_relative '../../lib/baidu-sms'

RSpec.describe BaiduSMS::AdgroupService do
  
  before(:all) do
    yml = YAML.load_file(File.expand_path("../../../credentials.yml", __FILE__)) # create this if you want to test!
    @service = BaiduSMS::AdgroupService.new(yml)
  end
  
  it "can list adgroup IDs" do
    adgroup_info = @service.get_all_adgroup_id
    expect(adgroup_info.size).to be > 0
    expect(adgroup_info.first.class).to eq(Hash)
  end
  
end