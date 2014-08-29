require 'spec_helper'

module SandthornEventFilter
  module Matchers
    describe SequenceNumberMatcher do
      let(:event) do
        {
          sequence_number: 1
        }
      end

      context "when the event has a larger sequence number" do
        it "should match" do
          sequence_number = event[:sequence_number]
          matcher = SequenceNumberMatcher.new(sequence_number - 1)
          expect(matcher).to match(event)
        end
      end

      context "when the event has the same or lower sequence number" do
        it "should not match" do
          sequence_number = event[:sequence_number]
          exact_matcher = SequenceNumberMatcher.new(sequence_number)
          larger_matcher = SequenceNumberMatcher.new(sequence_number + 1)
          expect(exact_matcher).to_not match(event)
          expect(larger_matcher).to_not match(event)
        end
      end
    end
  end
end