module BaiduSMS
  module Core

    BAIDU_HOST = { basic: "http://api.baidu.com", secure: "https://api.baidu.com" }
    SMS_RESOURCE = "/sem/sms/v3/"
    COMMON_RESOURCE = "/sem/common/v2"
    AUTH_NS = "ns2"

    def authorise_headers(username, password, token)
      { auth_namespace('AuthHeader') => { auth_namespace('username') => username,
                                          auth_namespace('password') => password,
                                          auth_namespace('token') => token } }
    end

    def initialise_client(service, credentials)
      wsdl_namespace_location = BAIDU_HOST[:secure] + SMS_RESOURCE + service + "?wsdl"
      authorise_namespace_location = BAIDU_HOST[:basic] + COMMON_RESOURCE
      Savon.client(wsdl: wsdl_namespace_location,
                  namespaces: { "xmlns:#{AUTH_NS}" => authorise_namespace_location },
                  soap_header: authorise_headers(credentials[:username], credentials[:password], credentials[:token])
                  )
    end

    def auth_namespace(str)
      "#{AUTH_NS}:#{str}"
    end

  end
end