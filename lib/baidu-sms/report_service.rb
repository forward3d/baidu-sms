module BaiduSMS
  class ReportService
    include BaiduSMS::Core

    REPORT_SERVICE = "ReportService"    

    def initialize(credentials)
      @client = initialise_client(REPORT_SERVICE, credentials)
    end

    def create_report(report, params)
      message = { reportRequestType: params.merge({reportType: report}) }

      response = call(:get_professional_report_id, message: message)
      response.body[:get_professional_report_id_response][:report_id]
    end

    def report_ready?(report_id)
      response = call(:get_report_state, message: { report_id: report_id })
      response.body[:get_report_state_response][:is_generated].to_i == 3
    end

    def report_url(report_id)
      response = call(:get_report_file_url, message: { report_id: report_id })
      response.body[:get_report_file_url_response][:report_file_path]
    end
    
    private
    
    def call(*args)
      response = @client.call(*args)
      # debugger
      header = response.header[:res_header]
      raise BaiduSMSInvalidRequestError.new("#{header[:failures][:code]} - #{header[:failures][:message]}") unless header[:status].to_i == 0
      response
    end
    
    class BaiduSMSInvalidRequestError < StandardError; end
  end
end
