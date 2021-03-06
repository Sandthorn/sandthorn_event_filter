module SandthornEventFilter
  module Matchers
    class EventNameMatcher < Matcher

      def initialize(types)
        @types = Array(types)
      end

      def match?(event)
        @types.any? { |type| event[:event_name].to_s == type.to_s }
      end

    end
  end
end