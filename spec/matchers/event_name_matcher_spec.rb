require 'spec_helper'

module SandthornEventFilter
  module Matchers
    describe EventNameMatcher do
      let(:foo_event) { { aggregate_event_name: "Foo"} }
      let(:bar_event) { { aggregate_event_name: "Bar"} }

      describe ".match?" do
        context "when given one event name" do
          context "and given an event of that name" do
            it "should return true" do
              filter = EventNameMatcher.new("Foo")
              expect(filter.match?(foo_event)).to be_truthy
            end
          end

          context "when given a non-matching event" do
            it "should return false" do
              filter = EventNameMatcher.new("Foo")
              expect(filter.match?(bar_event)).to be_falsey
            end
          end
        end

        context "when given multiple event names" do
          it "should return true if event matches any of the input event names" do
            filter = EventNameMatcher.new(["Bar", "Foo"])
            expect(filter.match?(foo_event)).to be_truthy
            expect(filter.match?(bar_event)).to be_truthy
          end
        end
      end
    end
  end
end