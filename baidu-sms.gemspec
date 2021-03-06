require File.join(File.expand_path('../lib', __FILE__), 'baidu-sms', 'version')

Gem::Specification.new do |gem|
  gem.name          = "baidu-sms"
  gem.version       = BaiduSMS::VERSION
  gem.authors       = ["Robert Borkowski", "Daniel Padden"]
  gem.email         = ["robert.borkowski@forward3d.com", "daniel.padden@forward3d.com"]
  gem.description   = %q{Baidu Search Marketing Service API}
  gem.summary       = %q{Wrapper for connecting to the Baidu Search Marketing API}
  gem.homepage      = "https://github.com/forward3d/baidu-sms"

  gem.files         = ['lib/baidu-sms.rb',
                        'lib/baidu-sms/core.rb',
                        'lib/baidu-sms/report_service.rb',
                        'lib/baidu-sms/reports.rb',
                        'lib/baidu-sms/level_of_details.rb',
                        'lib/baidu-sms/device.rb',
                        'lib/baidu-sms/version.rb']
  
  gem.executables   = [] #gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = [] #gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'savon'
  gem.add_dependency 'curb'
  gem.add_development_dependency 'rspec'
  
  gem.license = 'MIT'
end
