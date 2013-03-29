#!/usr/bin/env rake
require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec) { |t| t.rspec_opts = "--colour" }
task :default => :spec
