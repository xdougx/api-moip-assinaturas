Gem::Specification.new do |s|
  s.name        = 'api-moip-assinaturas'
  s.version     = '0.1.0'
  s.date        = '2013-06-10'
  s.summary     = "Moip Assinaturas by Pixxel"
  s.description = "Gem desenvolvida para atender aos requisitos do moip api de assinaturas"
  s.authors     = ["Douglas Rossignolli"]
  s.email       = 'douglas@pixxel.net.br'
  s.homepage    = 'http://pixxel.net.br'
  s.files       = Dir["{lib/**/*.rb,README.rdoc,test/**/*.rb,Rakefile,*.gemspec}"]

  s.required_ruby_version     = '>= 1.9.3'
  s.required_rubygems_version = '>= 1.8.11'
  s.add_development_dependency 'httparty', '~> 0.11.0', '>= 0.11.0'
  s.add_development_dependency 'json', '~> 1.7.7', '>= 1.7.7'
  s.add_development_dependency 'activemodel', '~> 3.2.12', '>= 3.2.12'
end