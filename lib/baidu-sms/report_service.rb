module BaiduSMS
  class ReportService
    include BaiduSMS::Core

    SERVICE_NAME = "ReportService"    
    MESSAGE_PARAM_ORDER = [ :performanceData, :startDate, :endDate, :levelOfDetails, :reportType, :device ]

    def initialize(credentials, options = {})
      @client = initialise_client(SERVICE_NAME, credentials)
    end

    def create_report(report, params)
      params.merge!({reportType: report})
      message = { reportRequestType: process_message_params(params) }
      response = @client.call(:get_professional_report_id, message: message)
      response.body[:get_professional_report_id_response][:report_id]
    end

    def report_ready?(report_id)
      response = @client.call(:get_report_state, message: { report_id: report_id })
      response.body[:get_report_state_response][:is_generated].to_i == 3
    end

    def report_url(report_id)
      response = @client.call(:get_report_file_url, message: { report_id: report_id })
      response.body[:get_report_file_url_response][:report_file_path]
    end
    
    private
    
    def process_message_params(message)
      MESSAGE_PARAM_ORDER.inject({}) do |result, param|
        result[param] = process_param(message[param]) if message[param]
        result
      end
    end
    
    def process_param(param)
      return format_date(param) if [:startDate, :endDate].include? param
      param
    end
    
    def format_date(date)
      date = Date.parse(date) if date.is_a? string
      date.strftime("%FT%T")
    end
    
  end
end
