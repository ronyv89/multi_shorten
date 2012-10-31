Gem::Specification.new do |s|
  s.name        = 'multi_shorten'
  s.version     = '0.0.1'
  s.date        = '2012-10-31'
  s.summary     = "Multiple URL Shorteners in one place"
  s.description = "Use multiple url shorteners to shorten single or multiple urls"
  s.authors     = ["Rony Varghese"]
  s.email       = 'ronyv250289@gmail.com'
  s.files       = ["lib/multi_shorten/client.rb", "lib/multi_shorten/url_shorteners.rb", "lib/multi_shorten.rb", "README.md"]
  s.homepage    = 'https://github.com/ronyv89/multi_shorten'
  s.add_dependency 'httparty'
  s.add_dependency 'active_support'
end