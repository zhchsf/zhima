$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'zhima'
require 'webmock/rspec'
require 'support/stub_helpers'

private_key = <<-KEY
-----BEGIN PRIVATE KEY-----
MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAKo93zk1OV0pFZmV
/yAoOVYfCsNoXsjg6KPMhAkxJDTdI+C0bIL4iJbXXZjTDaCUu0gYWTNOCMdNCJmI
EyoLasQIrb8/a+6kMiTPjUjPRevflKlMas+TQZHLTosrKrSdxIKiKZAA76irgvYz
N4C1o/vYHheInGLmm2N7ruyI71shAgMBAAECgYAU8d3HzQuMsaRNrA2iaDB9rv4F
Ao8+yaT1mhDYjKo2sspaN/htuKQdYsvKJJU1n3bXLN+0lzIvSwP2163760GsPyfe
WsHUkEKL1c7e6kYNP69rKCTaEkLpSnb4FCjeY/1IWC8HSGeH03MwD1Dek4ZgzAPQ
lTuwiXYzpgmFkWNabQJBAN6GiQUlHKbY6PFe41GqWFww3v8X/hWiYBxyPZZ1ikVk
p3s7KIoGuaRYHcgo4Gv8Tw2kyl1SuNI9Lvaf+T1hvdsCQQDD2eJra3MWC+tvGPE3
uiKGAP1GTnY0uXcr+ptlXsGbSDEVnZ4PibVOotgVrwfHtCyak1FDaLkfzmfydqBm
GUGzAkACbKDNh4v6XV6cUpZTa3Gu/3FOgipofe5iIPR+0SUCgIg6lXhpmI0pNzSL
27YmNwd9dJAn2CDfWX9LfI6wloIFAkAVotRomY41OUvhEhhT17RIqYNRaQmV+Yc4
zI6uPDGXPfpuMONtRAFLlqHYg2WQok7rJKstjzwkT2EcYA6IOPIRAkADbVnhW6bW
5EPxQk5wyZB2OMOCtsrNd+0jZioKDie7tuHi6z2jyTBABrlBAtmb7agVeMOkHqXM
Eyog2O2/0nMQ
-----END PRIVATE KEY-----
KEY

# 应为芝麻提供的public_key，此处直接使用上面私钥生成的对应公钥
public_key = <<-KEY
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCqPd85NTldKRWZlf8gKDlWHwrD
aF7I4OijzIQJMSQ03SPgtGyC+IiW112Y0w2glLtIGFkzTgjHTQiZiBMqC2rECK2/
P2vupDIkz41Iz0Xr35SpTGrPk0GRy06LKyq0ncSCoimQAO+oq4L2MzeAtaP72B4X
iJxi5ptje67siO9bIQIDAQAB
-----END PUBLIC KEY-----
KEY

Zhima.configure do |config|
  config.app_id = '1000000'
  config.private_key = private_key
  config.public_key = public_key
end

RSpec.configure do |config|
  config.include StubHelpers
end
