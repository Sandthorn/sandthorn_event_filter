module SandthornEventFilter
  module Matchers
    class IdentityMatcher < Matcher
      def match?(event)
        true
      end
    end
  end
end