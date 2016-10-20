module Zhima
  module Sign
    SIGN_METHOD = 'sha1'.freeze

    def self.sign(str)
      Config.mech_rsa.sign(SIGN_METHOD, str)
    end

    # TODO
    def self.verify()
    end
  end
end
