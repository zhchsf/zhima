module Zhima
  class Request
    GATEWAY = 'https://zmopenapi.zmxy.com.cn/openapi.do'
    SYSTEM_OPTIONS = {charset: 'UTF-8', version: '1.0', channel: 'app'}

    attr_accessor :biz_params, :sys_options

    def initialize(biz_params, sys_options)
      @biz_params = biz_params
      @sys_options = SYSTEM_OPTIONS.merge(sys_options)
    end

    def url
      params_value, sign = Param.encrypt(biz_params)
      opts = SYSTEM_OPTIONS.merge(sys_options)
             .merge(params: params_value, sign: sign, app_id: Config.app_id)
      query_str = Util.to_query(opts)
      [GATEWAY, query_str].join('?')
    end

    def execute
      response = RestClient.get url
      parse_response(response.body)
    end

    private

    # 芝麻返回的json数据解析，结果为真正的业务参数
    def parse_response(response_str)
      response_hash = JSON.parse(response_str)
      biz_response_sign = response_hash['biz_response_sign']
      biz_response = response_hash['biz_response']
      biz_response = Param.decrypt(biz_response) if response_hash["encrypted"]

      if response_hash["encrypted"] && !Sign.verify?(biz_response_sign, biz_response)
        raise VerifySignError.new('sign解签错误')
      else
        JSON.parse(biz_response)
      end
    end
  end
end
