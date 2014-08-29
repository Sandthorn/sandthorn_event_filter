require "sandthorn_event_filter/version"
require "sandthorn_event_filter/event"
require "sandthorn_event_filter/filter"

module SandthornEventFilter
  def self.filter(*args)
    Filter.new(*args)
  end
end
