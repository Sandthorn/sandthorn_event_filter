module SandthornEventFilter
  module Matchers
    class AggregateTypeMatcher

      def initialize(types)
        @types = Array(types)
      end

      def match?(event)
        @types.any? { |type| event[:aggregate_type].to_s == type.to_s }
      end

    end
  end
end