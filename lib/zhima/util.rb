module Zhima
  module Util
    def self.symbolize_hash_keys(hash)
      return hash.symbolize_keys! if hash.respond_to?(:symbolize_keys!)

      new_hash = {}
      hash.each do |key, value|
        new_hash[key.to_sym] = value
      end
      new_hash
    end

    def self.base64_encode(str)
      Base64.strict_encode64(str)
    end

    # 暂时只做了一级hash的处理
    def self.to_query(hash)
      hash.map{ |k, v| [k, URI.encode_www_form_component(v)].join("=") }.join("&")
    end
  end
end
