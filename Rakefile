require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
# load 'rails/tasks/engine.rake'

# load 'rails/tasks/statistics.rake'
load 'rails/tasks/engine.rake'


load 'rails/tasks/statistics.rake'



require 'bundler/gem_tasks'

Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test
