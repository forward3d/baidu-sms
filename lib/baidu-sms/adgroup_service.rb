module BaiduSMS
  class AdgroupService
    include BaiduSMS::Core

    ADGROUP_SERVICE = "AdgroupService"
    
    def initialize(credentials)
      @client = initialise_client(ADGROUP_SERVICE, credentials)
    end
    
    # Returns an array of elements like this:
    # {campaign_id: "12345", adgroup_ids: ["1", "2", "3"]}
    def get_all_adgroup_id
      response = @client.call(:get_all_adgroup_id)
      response.body[:get_all_adgroup_id_response][:campaign_adgroup_ids]
    end
    
  end
end