# Zhima

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/zhima`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

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
  config.private_key = private_key # 自己的私钥
  config.public_key = public_key # 芝麻给的公钥
end
```

芝麻信用分，调用方法如下(请自行查阅芝麻文档的业务参数组织params)：
```ruby
# 认证url  业务参数请参考 https://b.zmxy.com.cn/technology/openDoc.htm?id=67
Zhima::Score.auth_url(params)  # 第二个参数可hash传入芝麻需要的系统参数，不传亦可（下同，省略）

# 获取芝麻分
# https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.score.get@1.0@1.4&relType=API_DOC&type=API_INFO_DOC&LEFT_MENU_MODEnull#Seq_1
Zhima::Score.get(params)

# auth_query
# https://b.zmxy.com.cn/technology/openDoc.htm?id=453
Zhima::Score.auth_query(params)

# 芝麻callback url中的params参数解密
Zhima::Score.param_decrypt(params_str)
```

反欺诈信息验证：
```ruby
# 参数 https://b.zmxy.com.cn/technology/openDoc.htm?relInfo=zhima.credit.ivs.detail.get@1.0@1.2&relType=API_DOC&type=API_INFO_DOC&LEFT_MENU_MODEnull
Zhima::Ivs.get(params)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/zhchsf/zhima. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

