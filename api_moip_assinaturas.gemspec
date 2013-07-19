# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moip/version'

Gem::Specification.new do |s|
  s.name        = 'api-moip-assinaturas'
  s.version     = Moip::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.summary     = "Moip Assinaturas by Pixxel"
  s.description = "Gem desenvolvida para atender aos requisitos do moip api de assinaturas"
  s.authors     = ["Douglas Rossignolli"]
  s.email       = 'douglas@pixxel.net.br'
  s.homepage    = 'https://github.com/xdougx/api-moip-assinaturas'
  s.license     = 'Apache Licence 2.0'
    
  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]
    
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "rake"
  s.add_development_dependency 'httparty', '~> 0.11.0', '>= 0.11.0'
  s.add_development_dependency 'json', '~> 1.7.7', '>= 1.7.7'
  s.add_development_dependency 'activemodel', '~> 3.2.12', '>= 3.2.12'
  s.add_development_dependency 'i18n', '~> 0.6.1', '>= 0.6.1'

  s.add_dependency 'httparty', '~> 0.11.0', '>= 0.11.0'
  s.add_dependency 'json', '~> 1.7.7', '>= 1.7.7'
  s.add_dependency 'activemodel', '~> 3.2.12', '>= 3.2.12'
  s.add_dependency 'i18n', '~> 0.6.1', '>= 0.6.1'
  
end
