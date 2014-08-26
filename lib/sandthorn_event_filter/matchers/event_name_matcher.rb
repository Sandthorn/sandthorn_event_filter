module SandthornEventFilter
  module Matchers
    class EventNameMatcher < Matcher

      def initialize(types)
        @types = Array(types)
      end

      def match?(event)
        @types.any? { |type| event[:aggregate_event_name] == type }
      end

    end
  end
end