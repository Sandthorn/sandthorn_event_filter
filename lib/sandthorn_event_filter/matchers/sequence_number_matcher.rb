module SandthornEventFilter
  module Matchers
    class SequenceNumberMatcher < Matcher

      attr_reader :sequence_number

      def initialize(sequence_number)
        @sequence_number = sequence_number
      end

      def match?(event)
        event[:aggregate_sequence_number] > sequence_number
      end
    end
  end
end