module StubHelpers
  def stub_zhima_request(biz_response)
    encrypted_biz_param = Zhima::Util.base64_encode(Zhima::Param.rsa_encrypt(biz_response.to_json))
    sign = Zhima::Util.base64_encode(Zhima::Sign.sign(biz_response.to_json))

    mock_response = {
      encrypted: true,
      sign: {signSource: 'zhima_sign_value',  signResult: 'xxx'},
      biz_response_sign: sign,
      biz_response: encrypted_biz_param
    }.to_json

    stub_request(:any, /https:\/\/zmopenapi.zmxy.com.cn\/openapi.do.*/).to_return(
      :status => 200, 
      :body => mock_response, 
      :headers => {"Content-Type"=>"application/json"}
    )
  end
end
