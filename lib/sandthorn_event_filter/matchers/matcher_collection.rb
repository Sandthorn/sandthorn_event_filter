require 'forwardable'
require 'hamster/list'

module SandthornEventFilter
  module Matchers
    class MatcherCollection
      # = MatcherCollection
      # A collection of Matchers which can be applied to a collection of events.
      extend Forwardable
      attr_reader :matchers
      def_delegators :@matchers, :any?

      def initialize(matchers = Hamster.list)
        @matchers = matchers
      end

      # Returns all events that match all of the matchers in the collection
      def apply(events)
        events.select { |event| matchers.all? { |matcher| matcher.match?(event) } }
      end

      # Returns a new instance of MatcherCollection, with the new matchers added.
      # Since @matchers is a persistent, immutable Hamster::List,
      # adding all new matchers and sending the resulting list to the
      # new instance is safe.
      def add(input_matchers)
        input_matchers = Array(input_matchers)
        matchers = input_matchers.reduce(@matchers) do |matcher_collection, matcher|
          matcher_collection.cons(matcher)
        end
        self.class.new(matchers)
      end

    end
  end
end