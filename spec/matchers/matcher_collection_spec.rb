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
            matchers = [IdentityMatcher.new, IdentityMatcher.new]
            new_chain = chain.add(matchers)
            matchers.each do |matcher|
              expect(matcher).to receive(:match?).exactly(3).times.and_call_original
            end
            new_chain.apply(events)
          end
        end
      end

      describe ".match?" do
        context "when all the matchers match" do
          it "returns true" do
            filters = [IdentityMatcher.new, IdentityMatcher.new]
            new_chain = chain.add(filters)
            expect(new_chain).to match({foo: :bar})
          end
        end

        context "when one matchers doesn't match" do
          it "returns false" do
            filters = [IdentityMatcher.new, NotMatcher.new(IdentityMatcher.new)]
            new_chain = chain.add(filters)
            expect(new_chain).to_not match({foo: :bar})
          end
        end
      end

    end
  end
end