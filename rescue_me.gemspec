# -*- encoding: utf-8 -*-
Kernel.load File.expand_path('../lib/rescue_me/version.rb', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'rescue_me'
  s.version     = RescueMe::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Arild Shirazi']
  s.email       = ['as4@eshirazi.com']
  s.homepage    = 'https://github.com/ashirazi/rescue_me'
  s.summary     = 'Retry a block of code that might fail due to temporary errors.'
  s.description = 'Provides a convenience method to retry blocks of code that might fail due to temporary errors, e.g. a network service that becomes temporarily unavailable. The retries are timed to back-off exponentially (2^n seconds), hopefully giving time for the remote server to recover.'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = 'rescue_me'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'test-unit'
  s.add_development_dependency 'guard-test'
  s.add_development_dependency 'shoulda'

  s.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.rdoc]
  s.require_path = 'lib'
end

