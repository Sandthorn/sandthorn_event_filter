require 'spec_helper'

module SandthornEventFilter
  module Matchers
    describe Extract do
      let(:foo_event) { { aggregate_type: "Foo", event_name: "foo" } }
      let(:bar_event) { { aggregate_type: "Bar", event_name: "bar" } }

      context "when given only class matchers" do
        let(:foo_extractor) { Extract.new(types: "Foo") }


        context "when given a matching event" do
          it "should match" do
            expect(foo_extractor.match?(foo_event)).to be_truthy
          end
        end

        context "when given a non-matching event" do
          it "shouldn't match" do
            expect(foo_extractor.match?(bar_event)).to be_falsey
          end
        end
      end

      context "when given event_name matchers" do
        let(:foo_extractor) { Extract.new(events: "foo") }

        context "when given a matching event" do
          it "should match" do
            expect(foo_extractor.match?(foo_event)).to be_truthy
          end
        end

        context "when given a non-matching event" do
          it "should not match" do
            expect(foo_extractor.match?(bar_event)).to be_falsey
          end
        end
      end

      context "when given combinations of matchers" do
        let(:combo) { Extract.new(types: "Foo", events: "foo") }
        context "when given an event that matches all of the criteria" do
          it "should match" do
            expect(combo.match?(foo_event)).to be_truthy
          end
        end

        context "when given a partially matching event" do
          it "should not match" do
            event = { event_name: "foo", aggregate_type: "Baz" }
            expect(combo.match?(event)).to be_falsey
          end
        end
      end

    end
  end
end