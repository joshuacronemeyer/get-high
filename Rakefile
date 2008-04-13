require 'rubygems'
require 'rake/testtask'
require 'ftools'


task :default => :test

task :test do |t|
  Rake::TestTask.new do |t|
    t.test_files = FileList['*test*.rb']
    t.verbose = true
  end
end
 
