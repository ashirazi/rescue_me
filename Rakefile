#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rspec/core/rake_task"


# require 'rdoc/task'
# Rake::RDocTask.new do |rdoc|
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title = "rescue_me #{RescueMe::VERSION}"
#   rdoc.rdoc_files.include('README*')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end
RSpec::Core::RakeTask.new(:spec)
task :default => :spec
