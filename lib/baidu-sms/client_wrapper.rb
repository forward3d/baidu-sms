module BaiduSMS
  class ClientWrapper
    
    RETRYABLE_EXCEPTIONS = [HTTPI::Error, Curl::Err::CurlError]
    
    def initialize(savon_client)
      @client = savon_client
      @max_retries = 10
    end
    
    def call(*args)
      @current_retry = 0
      begin
        response = @client.call(*args)
        header = response.header[:res_header]
        raise BaiduSMSInvalidRequestError.new("#{header[:failures][:code]} - #{header[:failures][:message]}") unless header[:status].to_i == 0
        response
      rescue *RETRYABLE_EXCEPTIONS => e
        @current_retry += 1
        retry unless @current_retry > @max_retries
        raise e
      end
    end
    
  end
  
  class BaiduSMSInvalidRequestError < StandardError; end
  
end