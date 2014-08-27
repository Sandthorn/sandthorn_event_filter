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
          filter = Filter.new(events).extract(types: "Foo")
          filtered_events = filter.events
          expect(filtered_events.length).to eq(1)
          expect(filtered_events).to include(events.first)
        end
      end
    end

    describe ".apply" do
      let(:events) { [{ aggregate_type: "Foo" }, { aggregate_type: "Bar" }] }
      it "should return the filtered result" do
        filter = Filter.new.extract(types: "Foo")
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
          other_filter = filter.extract(types: "Foo")
          expect(filter.events).to eq(events)
        end

        describe "the new filter" do
          it "should be a new filter instance" do
            filter = Filter.new(events)
            other_filter = filter.extract(types: "Foo")
            expect(other_filter).to_not equal(filter)
          end

          it "should have the same original events" do
            filter = Filter.new(events)
            other_filter = filter.extract(types: "Foo")
            expect(other_filter.original_events).to eq(filter.original_events)
          end
        end
      end
    end

    describe ".select and .reject" do
      let(:events) { [{aggregate_type: "Foo"}, {aggregate_type: "Bar"}] }
      it "should return a new filter" do
        filter = Filter.new(events)
        reject = filter.select { |e| e[:aggregate_type] == "Foo" }
        select = filter.reject { |e| e[:aggregate_type] == "Bar" }
        expect(reject).to be_kind_of Filter
        expect(select).to be_kind_of Filter
        expect(select.events).to eq([events.first])
        expect(reject.events).to eq([events.first])
      end
    end

  end

  describe 'tests on actual data' do
    let(:events) { SandthornEventFilter::Fixtures::EVENTS }

    context 'when extracting `new` events' do
      it "should return matching events" do
        new_events_filter = Filter.new(events).extract(events: "new")
        expect(new_events_filter.length).to eq(2)
        event = Event.wrap(new_events_filter.first)
        expect(event.name).to eq("new")
      end
    end

    context 'when removing `new` events' do
      it "should return matching events" do
        filter = Filter.new(events).remove(events: 'new')
        filtered = filter.events
        expect(filtered.length).to eq(18)
      end
    end

    context 'when extracting events for an aggregate type' do
      it "should return only matching events" do
        filter = Filter.new(events).extract(types: 'SandthornTest')
        filtered = filter.events
        expect(filtered.length).to eq(1)
        expect(Event.wrap(filtered.first).aggregate_type).to eq("SandthornTest")
      end
    end

    context 'when removing evnets for an aggregate type' do
      it "should returning matching events" do
        filter = Filter.new(events).remove(types: 'SandthornTest')
        filtered = filter.events
        expect(filtered.length).to eq(19)
        expect(filtered).to all( have_aggregate_type 'SandthornProduct' )
      end
    end

  end

end