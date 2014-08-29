if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start
end

require 'sandthorn_event_filter'
require './spec/data/events'

require 'sandthorn_event_filter/rspec/custom_matchers'

RSpec.configure do |config|
end
