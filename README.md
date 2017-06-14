# Zhima

芝麻信用

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zhima'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zhima

## Usage
配置(config/initializers/zhima.rb)：
```ruby
Zhima.configure do |config|
  config.app_id = 'xxxxxxx' # 应用id
  config.private_key = File.read('private_key.pkcs8') # 自己的私钥
  config.public_key = File.read('public_key.pkcs8') # 芝麻给的公钥
end
```

芝麻信用分，调用方法如下(请自行查阅芝麻文档的业务参数组织params)：
```ruby
# 认证url  业务参数请参考 https://b.zmxy.com.cn/technology/openDoc.htm?id=67
params = {
  identity_type: '2', 
  identity_param: {certNo: 'idcard_no', name: 'name', certType: 'IDENTITY_CARD'}, 
  biz_params: {auth_code: 'M_H5', channelType: 'app', state: '100111211'}
}
system_options = {charset: 'UTF-8', version: '1.0', channel: 'app'} # 可省略，默认为这些参数
Zhima::Score.auth_url(params, system_options)  # 第二个参数system_options传入芝麻需要的系统参数，不传亦可（下同，省略）

# 获取芝麻分
# https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.score.get@1.0@1.4&relType=API_DOC&type=API_INFO_DOC&LEFT_MENU_MODEnull#Seq_1
params = {
  transaction_id: 'transaction_id', 
  product_code: 'w1010100100000000001',
  open_id: 'open_id'
}
Zhima::Score.get(params)

# auth_query
# https://b.zmxy.com.cn/technology/openDoc.htm?id=453
params = {
  identity_type: '2', 
  identity_param: {
    certNo: 'id_card_no', name: 'name', certType: 'IDENTITY_CARD'
  }
}
Zhima::Score.auth_query(params)

# 芝麻callback url中的params参数解密
Zhima::Score.param_decrypt(params_str)
```

反欺诈信息验证：
```ruby
# 参数 https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.ivs.detail.get@1.0@1.2&relType=API_DOC&type=API_INFO_DOC&LEFT_MENU_MODEnull
params = {
  product_code: 'w1010100000000000103',
  transaction_id: 'transaction_id',
  cert_no: '身份证',
  cert_type: '100',
  name: 'name',
  mobile: '18888888888'
}
Zhima::Ivs.get(params)
```

行业关注名单2.0
```ruby
params = {
  product_code: 'w1010100100000000022',
  transaction_id: 'transaction_id',
  open_id: '268800000000000000000000'
}
Zhima::WatchList.get(params)
```

申请欺诈评分
```ruby
# 参数 https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.antifraud.score.get@1.0@1.1&relType=API_DOC&LEFT_MENU_MODE=null&view_mode=null
params = {
  product_code: 'w1010100003000001100',
  transaction_id: 'transaction_id',
  cert_type: 'IDENTITY_CARD',
  cert_no: '证件号',
  name: '牛德华',
  mobile: '13899999999',
  email: 'xxx@xxx.com',
  bank_card: '8888',
  address: '中南海1号楼'
}
Zhima::Antifraud.get(params)
```

欺诈信息验证3.0
```ruby
# 参数 https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.antifraud.verify@1.0@1.1&relType=API_DOC&LEFT_MENU_MODE=null&view_mode=null
params = {
  product_code: 'w1010100000000002859',
  transaction_id: 'transaction_id',
  cert_type: 'IDENTITY_CARD',
  cert_no: '证件号',
  name: '牛德华',
  mobile: '13899999999',
  email: 'xxx@xxx.com',
  bank_card: '8888',
  address: '中南海1号楼'
}
Zhima::Antifraud.verify(params)
```

欺诈关注清单
```ruby
# 参数 https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.antifraud.risk.list@1.0@1.0&relType=API_DOC&LEFT_MENU_MODE=null&view_mode=null
params = {
  product_code: 'w1010100003000001283',
  transaction_id: 'transaction_id',
  cert_type: 'IDENTITY_CARD',
  cert_no: '证件号',
  name: '牛德华',
  mobile: '13899999999',
  email: 'xxx@xxx.com',
  bank_card: '8888',
  address: '中南海1号楼'
}
Zhima::Antifraud.risk_list(params)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zhchsf/zhima. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

