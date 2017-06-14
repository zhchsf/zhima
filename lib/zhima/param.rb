module Zhima
  # 业务参数params加解密
  class Param
    # {identity_type: 2, identity_param: URI.encode({certNo: 'xxx', name: 'xxx', certType: 'IDENTITY_CARD'}.to_json), biz_params: URI.encode({auth_code: 'M_APPPC_CERT', channelType: 'apppc'}.to_json)}
    # 返回两个参数：加密后的params，及sign
    def self.encrypt(params)
      params = Util.symbolize_hash_keys(params)
      params.each { |key, value| params[key] = value.to_json if value.is_a? Hash }
      param_str = Util.to_query(params)
      [
        Util.base64_encode(rsa_encrypt(param_str)),
        Util.base64_encode(Sign.sign(param_str))
      ]
    end

    def self.rsa_encrypt(str)
      str.split('').each_slice(117).inject('') do |s, bytes|
        s += Config.zm_rsa.public_encrypt(bytes.join)
        s
      end
    end

    def self.decrypt(param_str)
      # strict_decode64 decode64
      encrypted_str = Base64.decode64 URI.decode(param_str)
      encrypted_str.split('').each_slice(128).inject('') do |str, bytes|
        str += Config.mech_rsa.private_decrypt bytes.join
        str
      end
    end
  end
end
