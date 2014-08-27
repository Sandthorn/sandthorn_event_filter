require "bundler/gem_tasks"
require 'sandthorn_event_filter'
require 'dotenv/tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -I lib -r sandthorn_event_filter.rb"
end
