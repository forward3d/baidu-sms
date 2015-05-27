module BaiduSMS
  class KeywordMatchTypes
    
    MATCH_TYPES = {
      '1' => 'exact-match',
      '2' => 'advanced-phrase-match',
      '3' => 'broad-match'
    }
    
    def self.lookup(code)
      raise UnknownMatchTypeException, "Cannot find a match type for match type number #{code}" unless MATCH_TYPES[code]
      MATCH_TYPES[code]
    end
    
  end
  
  class UnknownMatchTypeException < Exception ; end
end