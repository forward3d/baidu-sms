module BaiduSMS
  module Reports
    
    ACCOUNTS = 2
    CAMPAIGN = 10
    AD_GROUP = 11
    KEYWORD = 14
    CREATIVE = 12
    KEYWORDS = 9
    LOCATION = 3
    SEARCH_TERM = 6
    MATCHING = 15

    def self.from_name(str)
      self.const_get(str.upcase)
    end
    
  end
end
