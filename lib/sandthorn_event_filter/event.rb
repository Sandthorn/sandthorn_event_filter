require 'delegate'
module SandthornEventFilter
  class Event < SimpleDelegator
    # Wraps raw event data and encapsulates knowledge about it
    # Makes sure the event is in canonical form
    # Delegates to the raw data hash, so you can still do Event.new(data)[:foo]

    def attribute_changed?(attribute)
      input_attributes = Array(attribute)
      changed_attributes.any? do |attr|
        input_attributes.include?(attr)
      end
    end

    def changed_attributes
      attribute_deltas.map do |delta|
        delta[:attribute_name]
      end
    end

    def attribute_deltas
      self.fetch(:event_args, {}).fetch(:attribute_deltas, [])
    end

    def aggregate_type
      self[:aggregate_type]
    end

    def name
      self[:event_name]
    end

    class << self
      alias_method :wrap, :new
    end

  end
end