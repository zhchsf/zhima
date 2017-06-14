require "rest-client"

module Zhima
  class Score
    AUTHORIZE_METHOD = 'zhima.auth.info.authorize'.freeze
    SCORE_METHOD = 'zhima.credit.score.get'.freeze
    AUTH_QUERY_METHOD = 'zhima.auth.info.authquery'.freeze

    # params参数 请参考 https://b.zmxy.com.cn/technology/openDoc.htm?id=67
    # 系统参数 SYSTEM_OPTIONS，可自己传入，一般只需要配置channel参数（与auth_code不对应芝麻信用会报错）
    def self.auth_url(params, sys_options = {})
      Request.new(params, sys_options.merge(method: AUTHORIZE_METHOD)).url
    end

    # https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.score.get@1.0@1.4&relType=API_DOC&type=API_INFO_DOC&LEFT_MENU_MODEnull#Seq_1
    def self.get(params, sys_options = {})
      Request.new(params, sys_options.merge(method: SCORE_METHOD)).execute
    end

    # https://b.zmxy.com.cn/technology/openDoc.htm?id=453
    def self.auth_query(params, sys_options = {})
      Request.new(params, sys_options.merge(method: AUTH_QUERY_METHOD)).execute
    end

    # 芝麻callback url中的params参数解密方法
    def self.param_decrypt(params_str)
      decrypted_str = Param.decrypt(params_str)
      URI.decode_www_form(URI.decode URI.escape(decrypted_str)).to_h
    end
  end
end
