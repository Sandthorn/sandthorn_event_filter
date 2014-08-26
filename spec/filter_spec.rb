require 'spec_helper'

module SandthornEventFilter
  describe Filter do
    let(:fake_events) { [:event, :other_event] }
    let(:filter) { Filter.new(fake_events) }

    describe "basic methods" do
      it "should respond to basic methods" do
        methods = [:each, :first, :last, :length, :empty?, :reject, :[]]
        methods.each do |method|
          expect(filter).to respond_to(method)
        end
      end
    end

    describe ".initialize" do

      it "is possible to create an empty filter" do
        expect { Filter.new }.to_not raise_error
      end

      it "exposes the original events" do
        expect(filter.original_events).to eq(fake_events)
      end

      it "has a filter chain" do
        expect(filter.matchers).to_not be_nil
      end
    end

    describe ".events" do
      context "when there are no matchers" do
        it "should return the original events" do
          expect(filter.events).to eq(fake_events)
        end
      end

      context "when there is a filter" do
        let(:events) { [{ aggregate_type: "Foo" }, { aggregate_type: "Bar" }] }
        it "should return the filtered result" do
          filter = Filter.new(events).extract(classes: "Foo")
          filtered_events = filter.events
          expect(filtered_events.length).to eq(1)
          expect(filtered_events).to include(events.first)
        end
      end
    end

    describe ".apply" do
      let(:events) { [{ aggregate_type: "Foo" }, { aggregate_type: "Bar" }] }
      it "should return the filtered result" do
        filter = Filter.new.extract(classes: "Foo")
        filtered_events = filter.apply(events)
        expect(filtered_events.length).to eq(1)
        expect(filtered_events).to include(events.first)
      end
    end

    describe "chaining" do
      let(:events) { [{aggregate_type: "Foo"}, {aggregate_type: "Bar"}] }
      context "when chaining filters" do
        it "should leave the original filter untouched" do
          filter = Filter.new(events)
          other_filter = filter.extract(classes: "Foo")
          expect(filter.events).to eq(events)
        end

        describe "the new filter" do
          it "should be a new filter instance" do
            filter = Filter.new(events)
            other_filter = filter.extract(classes: "Foo")
            expect(other_filter).to_not equal(filter)
          end

          it "should have the same original events" do
            filter = Filter.new(events)
            other_filter = filter.extract(classes: "Foo")
            expect(other_filter.original_events).to eq(filter.original_events)
          end
        end
      end
    end

    describe ".select and .reject" do
      let(:events) { [{aggregate_type: "Foo"}, {aggregate_type: "Bar"}] }
      it "should return a new filter" do
        filter = Filter.new(events)
        expect(filter.select { |e| e }).to be_kind_of Filter
        expect(filter.reject { |e| !e }).to be_kind_of Filter
      end
    end

  end

end