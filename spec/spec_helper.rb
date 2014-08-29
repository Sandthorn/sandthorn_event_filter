if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
else
  require 'simplecov'
  SimpleCov.start
end

require 'sandthorn_event_filter'
require './spec/data/events'


RSpec.configure do |config|
end
RSpec::Matchers.define :have_name do |expected|
  match do |actual|
    actual[:event_name] == expected
  end
end

RSpec::Matchers.define :have_aggregate_type do |expected|
  match do |actual|
    actual[:aggregate_type] == expected
  end
end
