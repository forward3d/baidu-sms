module BaiduSMS
  module Core

    BAIDU_HOST = { basic: "http://api.baidu.com", secure: "https://api.baidu.com" }
    SMS_RESOURCE = "/sem/sms/v3/"
    COMMON_RESOURCE = "/sem/common/v2"
    AUTH_NS = "ns2"
    DEFAULT_CLIENT_OPTIONS = { open_timeout: 300, read_timeout: 300, ssl_verify_mode: :none }

    def authorise_headers(username, password, token)
      { auth_namespace('AuthHeader') => { auth_namespace('username') => username,
                                          auth_namespace('password') => password,
                                          auth_namespace('token') => token } }
    end

    def initialise_client(service, credentials, options = {})
      client_options = set_client_options(options)
      wsdl_namespace_location = BAIDU_HOST[:secure] + SMS_RESOURCE + service + "?wsdl"
      authorise_namespace_location = BAIDU_HOST[:basic] + COMMON_RESOURCE
      Savon.client(wsdl: wsdl_namespace_location,
                  namespaces: { "xmlns:#{AUTH_NS}" => authorise_namespace_location },
                  soap_header: authorise_headers(credentials[:username], credentials[:password], credentials[:token]),
                  open_timeout: client_options[:open_timeout],
                  read_timeout: client_options[:read_timeout],
                  ssl_verify_mode: client_options[:ssl_verify_mode]
                  )
    end

    private

    def set_client_options(options)
      DEFAULT_CLIENT_OPTIONS.inject({}) { |i, (k, v)| i[k] = options[k] || v; i }
    end

    def auth_namespace(str)
      "#{AUTH_NS}:#{str}"
    end

  end
end