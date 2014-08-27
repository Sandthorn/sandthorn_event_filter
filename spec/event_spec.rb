require 'spec_helper'

module SandthornEventFilter
  describe Event do
    let(:event) { Event.wrap(Fixtures::EVENTS.first) }
    let(:deltas) do [
        {:attribute_name => "name", :old_value => nil, :new_value => "Morgan"},
        {:attribute_name => "price", :old_value => nil, :new_value => "666"},
        {:attribute_name => "stock_status", :old_value => nil, :new_value => "instock"},
        {:attribute_name => "active", :old_value => nil, :new_value => true},
        {:attribute_name => "aggregate_id", :old_value => nil, :new_value => "da932773-dd06-43dc-8c0c-61837f009226"}]
    end

    describe "#attribute_changed?" do
      context "when the attribute is included in the attribute deltas" do
        it "should return true" do
          deltas.map { |delta| delta[:attribute_name] }.each do |attribute|
            expect(event.attribute_changed?(attribute)).to be_truthy
          end
        end
      end

      context "when the attribute is bogus" do
        it "should return false" do
          expect(event.attribute_changed?("foo")).to be_falsey
        end
      end
    end

    describe "#attribute_deltas" do
      it "should return the deltas" do
        expect(event.attribute_deltas).to eq(deltas)
      end
    end

  end

end