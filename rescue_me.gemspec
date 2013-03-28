# -*- encoding: utf-8 -*-
Kernel.load File.expand_path('../lib/rescue_me/version.rb', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'rescue_me'
  gem.version     = RescueMe::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ['Arild Shirazi']
  gem.email       = ['as4@eshirazi.com']
  gem.homepage    = 'https://github.com/ashirazi/rescue_me'
  gem.summary     = 'Retry a block of code that might fail due to temporary errors.'
  gem.description = 'Provides a convenience method to retry blocks of code that might fail due to temporary errors, e.g. a network service that becomes temporarily unavailable. The retries are timed to back-off exponentially (2^n seconds), hopefully giving time for the remote server to recover.'

  gem.required_rubygems_version = '>= 1.3.6'
  gem.rubyforge_project = 'rescue_me'

  gem.add_development_dependency 'bundler'
  # gem.add_development_dependency 'guard-test'
  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'simplecov'

  gem.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.rdoc]
  gem.require_path = 'lib'
end

# group :development do
#   gem 'rb-fsevent'
#   gem 'ruby_gntp'
#   platforms :ruby do
#     gem 'rb-readline'
#   end
#   gem "guard-test"
# end
