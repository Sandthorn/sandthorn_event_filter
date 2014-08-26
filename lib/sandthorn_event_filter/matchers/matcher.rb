module SandthornEventFilter
  module Matchers
    class Matcher
      # = Matcher
      # Abstract class.
      # Matches an event. Must implement a +match?+ method.
      # Used to filter collections of events.
      attr_reader :options

      def initialize(options = {})
        @options = options
      end

      def match?(event)
        raise NotImplementedError, "subclasses should override"
      end

    end
  end
end