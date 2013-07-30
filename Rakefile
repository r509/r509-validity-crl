require 'rubygems'
require 'rspec/core/rake_task'
require "#{File.dirname(__FILE__)}/lib/r509/validity/crl/version"

task :default => :spec
RSpec::Core::RakeTask.new(:spec)

namespace :gem do
    desc 'Build the gem'
    task :build do
        puts `yard`
        puts `gem build r509-validity-crl.gemspec`
    end

    desc 'Install gem'
    task :install do
        puts `gem install r509-validity-crl-#{R509::Validity::CRL::VERSION}.gem`
    end

    desc 'Uninstall gem'
    task :uninstall do
        puts `gem uninstall r509-validity-crl`
    end
end

desc 'Build yard documentation'
task :yard do
	puts `yard`
	`open doc/index.html`
end
