module Zhima
  class Config
    class << self
      attr_accessor :app_id, :private_key, :public_key

      def configure
        yield self
      end

      def mech_rsa
        @mech_rsa ||= OpenSSL::PKey::RSA.new private_key
      end

      def zm_rsa
        @zm_rsa ||= OpenSSL::PKey::RSA.new public_key
      end
    end
  end
end
