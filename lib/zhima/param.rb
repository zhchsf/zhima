module Zhima
  # 业务参数params加解密
  class Param
    # {identity_type: 2, identity_param: URI.encode({certNo: '410526198605109070', name: '王智超', certType: 'IDENTITY_CARD'}.to_json), biz_params: URI.encode({auth_code: 'M_APPPC_CERT', channelType: 'apppc'}.to_json)}
    # 返回两个参数：加密后的params，及sign
    # .slice(:identity_type, :identity_param, :biz_params)
    def self.encrypt(params)
      params = Util.symbolize_hash_keys(params)
      params.each { |key, value| params[key] = URI.encode(value.to_json) if value.is_a? Hash }
      param_str = Util.to_query(params)
      encrypted_str = param_str.split('').each_slice(117).inject('') do |str, bytes|
        str += encrypt_str(bytes.join())
        str
      end

      [
        Util.base64_and_uri_encode(encrypted_str), 
        Util.base64_and_uri_encode(Sign.sign(param_str))
      ]
    end

    def self.encrypt_str(str)
      Config.zm_rsa.public_encrypt str
    end

    def self.decrypt(param_str)
      # strict_decode64 decode64
      Config.mech_rsa.private_decrypt(Base64.decode64 param_str)
    end
  end
end
