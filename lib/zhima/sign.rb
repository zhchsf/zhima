module Zhima
  module Sign
    SIGN_METHOD = 'sha1'.freeze

    def self.sign(str)
      Config.mech_rsa.sign(SIGN_METHOD, str)
    end

    def self.verify?(sign, str)
      decode64_sign = Base64.strict_decode64(sign)
      Config.zm_rsa.verify(SIGN_METHOD, decode64_sign, str.force_encoding("utf-8"))
    end
  end
end
