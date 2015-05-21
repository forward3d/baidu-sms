module BaiduSMS
  class KeywordService
    include BaiduSMS::Core

    SERVICE_NAME = "KeywordService"

    def initialize(credentials)
      @client = initialise_client(SERVICE_NAME, credentials)
    end

    # Returns an array of elements that look like this:
    # {:keyword_id=>"1", :adgroup_id=>"1", :keyword=>"something", :price=>"1.00", :pc_destination_url=>"url", :match_type=>"2", :pause=>false, :status=>"41"}
    def get_keyword_by_adgroup_id(*adgroup_ids)
      response = @client.call(:get_keyword_by_adgroup_id, message: { adgroupIds: adgroup_ids })
      response.body[:get_keyword_by_adgroup_id_response][:group_keywords][:keyword_types]
    end
    
  end
end
