require 'delegate'
module SandthornEventFilter
  module Matchers
    class NotMatcher < SimpleDelegator
      def match?(event)
        !super
      end
    end
  end
end