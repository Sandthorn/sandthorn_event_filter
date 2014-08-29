module SandthornEventFilter
  module Rspec
    module CustomMatchers
      def self.install!
        if defined?(Rspec)
          ::RSpec::Matchers.define :have_name do |expected|
            match do |actual|
              actual[:event_name] == expected
            end
          end

          ::RSpec::Matchers.define :have_aggregate_type do |expected|
            match do |actual|
              actual[:aggregate_type] == expected
            end
          end

          ::RSpec::Matchers.define :match do |expected|
            match do |actual|
              actual.match?(expected)
            end
          end
        end
      end

      self.install!
    end
  end
end