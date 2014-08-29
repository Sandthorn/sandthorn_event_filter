require 'spec_helper'

module SandthornEventFilter
  module Matchers
    describe AggregateTypeMatcher do
      let(:foo_event) { { aggregate_type: "Foo"} }
      let(:bar_event) { { aggregate_type: "Bar"} }

      describe ".match?" do
        context "when given one class" do
          context "and given an event of that class" do
            it "should return true" do
              filter = AggregateTypeMatcher.new("Foo")
              expect(filter).to match(foo_event)
            end
          end

          context "when given a non-matching event" do
            it "should return false" do
              filter = AggregateTypeMatcher.new("Foo")
              expect(filter).to_not match(bar_event)
            end
          end
        end

        context "when given multiple types" do
          it "should return true if event matches any of the input types" do
            filter = AggregateTypeMatcher.new(["Bar", "Foo"])
            expect(filter).to match(foo_event)
            expect(filter).to match(bar_event)
          end
        end
      end

    end
  end
end