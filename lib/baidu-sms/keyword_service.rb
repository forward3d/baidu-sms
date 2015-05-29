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
      # If there are no keywords in the adgroup, we'll be missing the subelements
      return [] unless response.body[:get_keyword_by_adgroup_id_response][:group_keywords]
      keyword_info = response.body[:get_keyword_by_adgroup_id_response][:group_keywords][:keyword_types]
      # When we get a single keyword, it's a hash, not an array; coerce it into an array
      keyword_info = keyword_info.is_a?(Hash) ? [keyword_info] : keyword_info
      keyword_info.each do |keyword|
        keyword[:status] = BaiduSMS::KeywordStatuses.lookup(keyword[:status])
        keyword[:match_type] = BaiduSMS::KeywordMatchTypes.lookup(keyword[:match_type])
      end
      keyword_info
    end
    
  end
end
