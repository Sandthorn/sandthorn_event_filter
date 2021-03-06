require 'spec_helper'

module SandthornEventFilter
  module Matchers
    describe BlockMatcher do
      context "when the given block evaluates to true" do
        it "should match" do
          matcher = BlockMatcher.new do |event|
            true
          end
          expect(matcher).to match({})
        end
      end

      context "when the given block evaluates to false" do
        it "shouldn't match" do
          matcher = BlockMatcher.new do |event|
            false
          end
          expect(matcher).to_not match({})
        end
      end

    end
  end
end