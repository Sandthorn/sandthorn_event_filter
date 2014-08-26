module SandthornEventFilter
  module Matchers
    class BlockMatcher < Matcher

      def initialize(&block)
        @block = block
      end

      def match?(event)
        @block.call(event)
      end

    end
  end
end