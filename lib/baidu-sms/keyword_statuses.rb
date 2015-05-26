module BaiduSMS
  class KeywordStatuses
    
    STATUS_CODES = {
      '41' => 'eligible',
      '42' => 'paused',
      '43' => 'disapproved',
      '44' => 'invalid-search-low-cpc',
      '45' => 'to-be-activated',
      '46' => 'under-review',
      '47' => 'low-search-volume',
      '48' => 'approved-limited-invalid-mobile-url',
      '49' => 'desktop-invalid-search',
      '50' => 'mobile-invalid-search'
    }
    
    def self.lookup(code)
      raise UnknownStatusException, "Cannot find a status for status number #{code}" unless STATUS_CODES[code]
      STATUS_CODES[code]
    end
    
  end
  
  class UnknownStatusException < Exception ; end
  
end