require 'sandthorn_event_filter/matchers/matcher_collection'
require 'sandthorn_event_filter/matchers/matcher'
require 'sandthorn_event_filter/matchers/extract'
require 'sandthorn_event_filter/matchers/attribute_changed_matcher'
require 'sandthorn_event_filter/matchers/not_matcher'
require 'sandthorn_event_filter/matchers/identity_matcher'
require 'sandthorn_event_filter/matchers/class_matcher'
require 'sandthorn_event_filter/matchers/event_name_matcher'
require 'sandthorn_event_filter/matchers/block_matcher'
require 'sandthorn_event_filter/matchers/sequence_number_matcher'

module SandthornEventFilter
  class Filter
    # = Filter
    # A composable event filter.
    # Filters can be chained at will, but the actual filtering won't be done
    # until a method is called that needs actual data.
    #
    # Filter methods (+remove+, +extract+, +select+, +reject+) return new instances of Filter, and do not affect
    # the original filter.
    #
    # NOTE:
    # This class expects well-formed events as input, and does nothing to transform events.
    # TODO: throw error for malformed events? Or at least emit warning?
    extend Forwardable
    include Enumerable

    def_delegators :events, :each, :last, :length, :empty?, :[]

    attr_reader :matchers, :original_events

    def initialize(events = [], matchers = Matchers::MatcherCollection.new)
      @matchers = matchers
      @original_events = events
    end

    def events
      if @matchers.any?
        @filtered_events ||= apply(original_events)
      else
        @original_events
      end
    end

    def extract(*args)
      matcher = Matchers::Extract.new(*args)
      add_matcher(matcher)
    end

    # A remove matcher is a negated extract matcher
    def remove(*args)
      matcher = Matchers::NotMatcher.new(Matchers::Extract.new(*args))
      add_matcher(matcher)
    end

    def select(&block)
      matcher = Matchers::BlockMatcher.new(&block)
      add_matcher(matcher)
    end

    def reject(&block)
      matcher = Matchers::NotMatcher.new(Matchers::BlockMatcher.new(&block))
      add_matcher(matcher)
    end

    def add_matcher(matcher)
      # This works because .add returns a new MatcherCollection
      new_matchers = @matchers.add(matcher)
      self.class.new(original_events, new_matchers)
    end

    def apply(events)
      @matchers.apply(events)
    end

  end
end