require "rest-client"

module Zhima
  class Score
    GATEWAY = 'https://zmopenapi.zmxy.com.cn/openapi.do'
    SYSTEM_OPTIONS = {charset: 'UTF-8', version: '1.0', channel: 'app'}
    AUTHORIZE_METHOD = 'zhima.auth.info.authorize'
    SCORE_METHOD = 'zhima.credit.score.get'
    AUTH_QUERY_METHOD = 'zhima.auth.info.authquery'

    # params参数 请参考 https://b.zmxy.com.cn/technology/openDoc.htm?id=67
    # 系统参数 SYSTEM_OPTIONS，可自己传入，一般只需要配置channel参数（与auth_code不对应芝麻信用会报错）
    def self.auth_url(params, sys_options = {})
      url_by(params, sys_options.merge(method: AUTHORIZE_METHOD))
    end

    # https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.score.get@1.0@1.4&relType=API_DOC&type=API_INFO_DOC&LEFT_MENU_MODEnull#Seq_1
    # TODO verify sign
    def self.get(params, sys_options = {})
      score_url = url_by(params, sys_options.merge(method: SCORE_METHOD))
      response = RestClient.get score_url
      parse_response(response.body)
    end

    # https://b.zmxy.com.cn/technology/openDoc.htm?id=453
    def self.auth_query(params, sys_options = {})
      query_url = url_by(params, sys_options.merge(method: AUTH_QUERY_METHOD))
      response = RestClient.get query_url
      parse_response(response.body)
    end

    # 芝麻callback url中的params参数解密方法
    def self.param_decrypt(params_str)
      decrypted_str = Param.decrypt(params_str)
      URI.decode_www_form(URI.decode URI.escape(decrypted_str)).to_h
    end

    def self.url_by(params, sys_options)
      params_value, sign = Param.encrypt(params)
      opts = SYSTEM_OPTIONS.merge(sys_options)
             .merge(params: params_value, sign: sign, app_id: Config.app_id)
      query_str = Util.to_query(opts)
      [GATEWAY, query_str].join('?')
    end

    def self.parse_response(response_str)
      response_hash = JSON.parse(response_str)
      biz_response = response_hash["biz_response"]
      biz_response = Param.decrypt(biz_response) if response_hash["encrypted"]
      JSON.parse(biz_response)
    end
  end
end
