$LOAD_PATH.unshift './lib'
$LOAD_PATH.unshift './test'

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new(:test)

task :default => :test
