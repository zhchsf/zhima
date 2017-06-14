module Zhima
  # 行业关注名单2.0版
  class WatchList
    METHOD = 'zhima.credit.watchlistii.get'.freeze

    # https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.watchlistii.get@1.0@1.0&relType=API_DOC&LEFT_MENU_MODE=null
    def self.get(params, sys_options = {})
      Request.new(params, sys_options.merge(method: METHOD)).execute
    end
  end
end
