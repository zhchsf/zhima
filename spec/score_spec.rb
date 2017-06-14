describe Zhima::Score do
  describe "#auth_url" do
    let(:params) {
      {
        identity_type: '2',
        identity_param: {certNo: 'idcard_no', name: 'name', certType: 'IDENTITY_CARD'},
        biz_params: {auth_code: 'M_H5', channelType: 'app', state: '100111211'}
      }
    }

    it "return valid url" do
      url = Zhima::Score.auth_url(params)
      expect(url).not_to be_empty
    end
  end

  describe "score by openid" do
    before(:all) do
      params = {
        transaction_id: 'transaction_id',
        product_code: 'w1010100100000000001',
        open_id: 'open_id'
      }
      biz_response = {success: true, biz_no: 'ZM201611163000000193200377138988', zm_score: '802'}
      stub_zhima_request(biz_response)
      @result = Zhima::Score.get(params)
    end

    it "success" do
      expect(@result["success"]).to eq true
    end

    it "score is 802" do
      expect(@result["zm_score"]).to eq "802"
    end
  end

  describe "#auth_query" do
    before(:all) do
      params = {
        identity_type: '2',
        identity_param: {
          certNo: 'id_card_no', name: 'name', certType: 'IDENTITY_CARD'
        }
      }
      biz_response = {success: true, authorized: true, open_id: 'openid'}
      stub_zhima_request(biz_response)
      @result = Zhima::Score.auth_query(params)
    end

    it "success" do
      expect(@result["success"]).to eq true
    end

    it "open_id is openid" do
      expect(@result["open_id"]).to eq "openid"
    end
  end

  describe "#param_decrypt" do
    before(:all) do
      expect_response = {success: true, open_id: 'openid'}
      params_str, _ = Zhima::Param.encrypt(expect_response)
      @result = Zhima::Score.param_decrypt(params_str)
    end

    it "open_id is openid" do
      expect(@result["open_id"]).to eq "openid"
    end
  end
end
