$:.push File.expand_path("../lib", __FILE__)
require "r509/validity/crl/version"

spec = Gem::Specification.new do |s|
  s.name = 'r509-validity-crl'
  s.version = R509::Validity::CRL::VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = false
  s.summary = "A Validity::Writer and Validity::Checker for r509, implemented with a CRL loader backend"
  s.description = "A Validity::Writer and Validity::Checker for r509, implemented with a CRL loader backend"
  s.add_dependency 'r509', '>= 0.9.0'
  s.add_dependency 'rufus-scheduler'
  s.add_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'syntax'
  s.add_development_dependency 'simplecov'
  s.author = "Paul Kehrer"
  s.email = "paul.l.kehrer@gmail.com"
  s.homepage = "http://langui.sh"
  s.required_ruby_version = ">= 1.9.3"
  s.files = %w(README.md LICENSE.md Rakefile) + Dir["{lib,spec,doc}/**/*"]
  s.test_files= Dir.glob('test/*_spec.rb')
  s.require_path = "lib"
end

