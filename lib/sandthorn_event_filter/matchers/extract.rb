module SandthornEventFilter
  module Matchers
    class Extract < Matcher
      # = Extract
      # Extract is basically an AND matcher.
      # Given some matching criteria, it will construct submatchers,
      # for example creating a ClassMatcher if provided with classes.
      # Events match an Extract matcher if all of its submatchers match the event.
      def match?(event)
        submatchers_match?(event)
      end

      private

      def submatchers_match?(event)
        submatchers.all? { |subf| subf.match?(event) }
      end

      def submatchers
        @submatchers ||= construct_submatchers
      end

      def construct_submatchers
        matchers = []
        add_class_matcher(matchers, options)
        add_event_name_matcher(matchers, options)
        matchers
      end

      def add_class_matcher(matchers, options)
        if klasses = options[:classes]
          matchers << ClassMatcher.new(klasses)
        end
      end

      def add_event_name_matcher(matchers, options)
        if names = options[:events]
          matchers << EventNameMatcher.new(names)
        end
      end

    end
  end
end