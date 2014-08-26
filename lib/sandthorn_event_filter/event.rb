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
      self[:attribute_deltas] || []
    end

    class << self
      alias_method :wrap, :new
    end

  end
end