require 'rake/testtask'

desc "Run unit tests"
task :default => :test

Rake::TestTask.new do |t|
  t.pattern = 'test/unit/*_test.rb'
  t.verbose = true
end
