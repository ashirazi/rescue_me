# -*- encoding: utf-8 -*-
Kernel.load File.expand_path('../lib/rescue_me/version.rb', __FILE__)
## coding: utf-8
#lib = File.expand_path('../lib', __FILE__)
#$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'rescue_me/version'

Gem::Specification.new do |gem|
  gem.name        = 'rescue_me'
  gem.version     = RescueMe::VERSION
  gem.authors     = ['Arild Shirazi']
  gem.email       = ['as4@eshirazi.com']
  gem.description = 'Provides a convenience method to retry blocks of code that might fail due to temporary errors, e.g. a network service that becomes temporarily unavailable. The retries are timed to back-off exponentially (2^n seconds), hopefully giving time for the remote server to recover.'
  gem.summary     = 'Retry a block of code that might fail due to temporary errors.'
  gem.homepage    = 'https://github.com/ashirazi/rescue_me'
  gem.license     = 'MIT'

  gem.files        = Dir.glob('{lib}/**/*') + %w[LICENSE README.rdoc]
  gem.require_path = 'lib'
  #spec.files         = `git ls-files`.split($/)
  #spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  #spec.require_paths = ["lib"]

  gem.required_rubygems_version = '>= 1.3.6'
  gem.rubyforge_project = 'rescue_me'

  gem.add_development_dependency 'bundler'
  # gem.add_development_dependency 'guard-test'
  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'simplecov'

end

# group :development do
#   gem 'rb-fsevent'
#   gem 'ruby_gntp'
#   platforms :ruby do
#     gem 'rb-readline'
#   end
#   gem "guard-test"
# end
