require 'spec_helper'

module SandthornEventFilter
  module Matchers
    describe MatcherCollection do

      let(:events) { [:one, :two, :three] }
      let(:chain) { SandthornEventFilter::Matchers::MatcherCollection.new }

      describe ".add" do

        let(:filter) { Object.new }

        it 'returns a new chain' do
          new_chain = chain.add(filter)
          expect(new_chain).to be_kind_of MatcherCollection
          expect(new_chain).to_not equal(chain)
        end
        it 'adds a filter to the chain' do
          new_chain = chain.add(filter)
          expect(new_chain.matchers).to include(filter)
        end
      end

      describe ".apply" do
        context "when there are no matchers in the chain" do
          it "should return the original events" do
            expect(chain.matchers).to be_empty
            expect(chain.apply(events)).to eq(events)
          end
        end

        context "when there are matchers" do
          it "should call match? on the matchers for each event" do
            filters = [IdentityMatcher.new, IdentityMatcher.new]
            new_chain = chain.add(filters)
            filters.each do |filter|
              expect(filter).to receive(:match?).exactly(3).times.and_call_original
            end
            new_chain.apply(events)
          end
        end
      end

    end
  end
end