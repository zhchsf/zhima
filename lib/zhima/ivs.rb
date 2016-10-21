module Zhima
  # 反欺诈信息验证
  class Ivs
    METHOD = 'zhima.credit.ivs.detail.get'

    # https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.ivs.detail.get@1.0@1.2&relType=API_DOC&type=API_INFO_DOC&LEFT_MENU_MODEnull
    def self.get(params, sys_options = {})
      Request.new(params, sys_options.merge(method: METHOD)).execute
    end
  end
end
