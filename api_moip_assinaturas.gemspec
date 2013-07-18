# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require 'moip/version'

Gem::Specification.new do |s|
  s.name        = 'api-moip-assinaturas'
  s.version     = Moip::VERSION.dup
  s.platform   = Gem::Platform::RUBY
  s.summary     = "Moip Assinaturas by Pixxel"
  s.description = "Gem desenvolvida para atender aos requisitos do moip api de assinaturas"
  s.authors     = ["Douglas Rossignolli"]
  s.email       = 'douglas@pixxel.net.br'
  s.homepage    = 'https://github.com/xdougx/api-moip-assinaturas'
  s.license     = 'Apache Licence 2.0'
  s.files       = Dir["{lib/**/*.rb,lib/**/*.yml,README.rdoc,test/**/*.rb,Rakefile,*.gemspec}"]
  s.require_paths = ["lib"]

  s.required_ruby_version     = '>= 1.9.3'
  s.required_rubygems_version = '>= 1.8.11'

  s.add_dependency 'httparty', '>= 0.11.0'
  s.add_dependency 'json', '>= 1.7.7'
  s.add_dependency 'activemodel', '>= 4.0.0', '< 4.1'
  s.add_dependency 'i18n', '~> 0.6.1', '>= 0.6.1'
end
