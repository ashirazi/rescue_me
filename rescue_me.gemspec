# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rescue_me/version'

Gem::Specification.new do |spec|
  spec.name        = 'rescue_me'
  spec.version     = RescueMe::VERSION
  spec.authors     = ['Arild Shirazi']
  spec.email       = ['as4@eshirazi.com']
  spec.description = 'Provides a convenience method to retry blocks of code that might fail due to temporary errors, e.g. a network service that becomes temporarily unavailable. The retries are timed to back-off exponentially (2^n seconds), hopefully giving time for the remote server to recover.'
  spec.summary     = 'Retry a block of code that might fail due to temporary errors.'
  spec.homepage    = 'https://github.com/ashirazi/rescue_me'
  spec.license     = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'shoulda'
  spec.add_development_dependency 'simplecov'
end
