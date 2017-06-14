describe Zhima::Ivs do
  context "正常结果返回" do
    before(:all) do
      params = {
        product_code: 'w1010100000000000103',
        transaction_id: 'transaction_id',
        cert_no: 'xxxxxxxxxxxxxxxxxxxxxx',
        cert_type: '100',
        name: 'name',
        mobile: '18888888888'
      }
      biz_response = {
        success: true, biz_no: 'ZM201611173000000434300378670913',
        ivs_detail: [
          {
            code: 'CERTNO_Match_Trust_Self_Sharing_Good',
            description: URI.encode_www_form_component('身份证号与其他信息匹配，匹配后的信息被一个用户使用')
          },
          {
            code: 'PHONE_Match_Trust_Self_Recency_Good',
            description: URI.encode_www_form_component('电话号码与其他信息匹配，匹配后的信息近期较活跃')
          },
          {
            code: 'NAME_Match_Sharing_Good',
            description: URI.encode_www_form_component('姓名与其他信息匹配，匹配后的信息被一个用户使用')
          }
        ],
        ivs_score: 99
      }
      stub_zhima_request(biz_response)
      @result = Zhima::Ivs.get(params)
    end

    it "success" do
      expect(@result['success']).to eq true
    end

    it "ivs_detail has 3" do
      expect(@result['ivs_detail'].count).to eq 3
    end

    it "ivs_score is 99" do
      expect(@result['ivs_score']).to eq 99
    end
  end

  context "芝麻返回错误信息" do
    before(:all) do
      params = {
        product_code: 'w1010100000000000103',
        transaction_id: 'transaction_id',
        cert_no: 'xxxxxxxxxxxxxxxxxxxxxx',
        cert_type: '100',
        name: 'name',
        mobile: '18888888888'
      }
      mock_response = {
        encrypted: false,
        biz_response: {
          success: false,
          error_code: 'ZMCREDIT.transaction_id_repeat',
          error_message: '相同业务流水号但业务参数不一致，请求被拒绝'
        }.to_json
      }
      stub_zhima_request_without_encrypt(mock_response.to_json)
      @result = Zhima::Ivs.get(params)
    end

    it "success false" do
      expect(@result['success']).to eq false
    end

    it "return error_code" do
      expect(@result['error_code']).to eq 'ZMCREDIT.transaction_id_repeat'
    end
  end

  context "sign解签失败" do
    before(:all) do
      @params = {product_code: 'w1010100000000000103'}
      mock_response = {
        encrypted: true,
        sign: {signSource: 'zhima_sign_value',  signResult: 'xxx'},
        biz_response_sign: Zhima::Util.base64_encode("test"),
        biz_response: Zhima::Util.base64_encode(Zhima::Param.rsa_encrypt('test'))
      }
      stub_zhima_request_without_encrypt(mock_response.to_json)
    end

    it "raise error" do
      expect{ Zhima::Ivs.get(@params) }.to raise_error(Zhima::VerifySignError)
    end
  end
end
