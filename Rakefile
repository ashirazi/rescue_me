require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rescue_me"
    gem.summary = %Q{Retry a block of code that might fail due to temporary errors.}
    gem.description = %Q{Provides a convenience method to retry blocks of code \
that might fail due to temporary errors, e.g. a network service that becomes \
temporarily unavailable.  The retries are timed to back-off exponentially (2^n \
seconds), hopefully giving time for the remote server to recover.}
    gem.email = "as4@eshirazi.com"
    gem.homepage = "http://github.com/ashirazi/rescue_me"
    gem.authors = ["Arild Shirazi"]
    # gem.add_development_dependency "thoughtbot-shoulda", ">= 0"
    gem.add_development_dependency "shoulda", ">= 0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rescue_me #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
