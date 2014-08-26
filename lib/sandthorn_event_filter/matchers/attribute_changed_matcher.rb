module SandthornEventFilter
  module Matchers
    class AttributeChangedMatcher < Matcher

      attr_reader :attributes

      def initialize(attributes)
        @attributes = Array(attributes)
      end

      def match?(event)
        SandthornEventFilter::Event.wrap(event).attribute_changed?(attributes)
      end

    end
  end
end
