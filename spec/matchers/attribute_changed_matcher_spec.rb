require 'spec_helper'

module SandthornEventFilter
  module Matchers
    describe AttributeChangedMatcher do
      let(:event) do
        {
            aggregate_id:"555dc484-5727-44b1-a8da-0f85014d7204",
            aggregate_type: "ProductAggregates::Store",
            aggregate_version: 1,
            timestamp: Time.parse("2014-08-05 16:00:40.107738"),
            sequence_number: 3,
            event_name: "new",
            attribute_deltas: [
                {
                    attribute_name: "name",
                    new_value: nil,
                    old_value: nil
                },
                {
                    attribute_name: "description",
                    new_value: nil,
                    old_value: nil
                }
            ]
        }
      end

      describe ".match?" do
        context "when given a changed attributes" do
          it "should return true" do
            matcher = AttributeChangedMatcher.new("name")
            expect(matcher.match?(event)).to be_truthy
          end
        end
      end
    end
  end
end