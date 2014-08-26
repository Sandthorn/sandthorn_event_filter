module SandthornEventFilter
  module Matchers
    class ClassMatcher

      def initialize(klasses)
        @klasses = Array(klasses)
      end

      def match?(event)
        @klasses.any? { |klass| event[:aggregate_type] == klass.to_s }
      end

    end
  end
end