module Zhima
  # 申请欺诈评分 欺诈信息验证 欺诈关注清单
  class Antifraud
    GET_METHOD = 'zhima.credit.antifraud.score.get'.freeze
    VERIFY_METHOD = 'zhima.credit.antifraud.verify'.freeze
    RISK_LIST_METHOD = 'zhima.credit.antifraud.risk.list'.freeze

    # 申请欺诈评分
    # https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.antifraud.score.get@1.0@1.1&relType=API_DOC&LEFT_MENU_MODE=null&view_mode=null
    def self.get(params, sys_options = {})
      Request.new(params, sys_options.merge(method: GET_METHOD)).execute
    end

    # 欺诈信息验证3.0
    # https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.antifraud.verify@1.0@1.1&relType=API_DOC&LEFT_MENU_MODE=null&view_mode=null
    def self.verify(params, sys_options = {})
      Request.new(params, sys_options.merge(method: VERIFY_METHOD)).execute
    end

    # 欺诈关注清单
    # https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.antifraud.risk.list@1.0@1.0&relType=API_DOC&LEFT_MENU_MODE=null&view_mode=null
    def self.risk_list(params, sys_options = {})
      Request.new(params, sys_options.merge(method: RISK_LIST_METHOD)).execute
    end
  end
end
