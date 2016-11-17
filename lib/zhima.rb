require "zhima/version"
require "openssl"
require "base64"
require "uri"

module Zhima
  class << self
    def configure(&block)
      Config.configure(&block)
    end
  end
end

require_relative "zhima/config"
require_relative "zhima/score"
require_relative "zhima/ivs"
require_relative "zhima/watch_list"
require_relative "zhima/request"
require_relative "zhima/param"
require_relative "zhima/sign"
require_relative "zhima/util"
require_relative "zhima/errors"
