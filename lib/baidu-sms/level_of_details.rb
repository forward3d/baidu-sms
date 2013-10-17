module BaiduSMS
  module LevelOfDetails

    ACCOUNT = 2
    CAMPAIGN = 3
    AD_GROUP = 5
    KEYWORD = 6
    CREATIVE = 7
    KEYWORD_KEYWORD_ID = 11
    KEYWORD_PLUS_CREATIVE = 12

    def self.from_name(str)
      self.const_get(str.upcase)
    end
  
  end
end
