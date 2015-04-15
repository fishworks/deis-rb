Gem::Specification.new do |s|
  s.name        = 'deis'
  s.version     = '0.0.1.pre'
  s.date        = '2015-04-13'
  s.summary     = "Deis Client lib"
  s.description = "A Deis client library for Ruby"
  s.authors     = ["Matthew Fisher"]
  s.email       = 'mfisher@engineyard.com'
  s.files       = ["lib/deis.rb"]
  s.homepage    =
    'http://rubygems.org/gems/deis'
  s.license       = 'MIT'
  s.add_runtime_dependency 'httparty'
end
