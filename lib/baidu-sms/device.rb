module BaiduSMS
  module Device

    ALL = 0
    DESKTOP = 1
    MOBILE = 2

    def self.from_name(str)
      self.const_get(str.upcase)
    end
  
  end
end
