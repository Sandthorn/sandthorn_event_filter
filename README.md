# SandthornEventFilter

SandthornEventFilter is a library for creating composable event filters.
They are composable in the following senses: 

- chained filters get boiled down to a single expression, meaning we can filter in just one pass
- filters are immutable and can be extended with further chaining

## Installation

Add this line to your application's Gemfile:

    gem 'event_filter'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install event_filter

## Usage

The basic way to use a Filter is to wrap an array of Events:

    filter = SandthornEventFilter::Filter.new(my_events)

You can always call `.events` to get the filtered events:
    
    # This filter is empty, and will return the original events
    filter.events
    # => [...]
    
You can also enumerate on the filter directly:

    filter.each { |event| puts event.inspect }
    
`extract` returns a new filter that extracts the chosen events:

    new_events = filter.extract(events: "new", classes: MyAggregate, after_sequence_number: 100)
    new_events.events
    # => events that match the criteria
    
`remove` returns a new filter with removes the chosen events:

    except_new = filter.remove(events: "new")
    except_new.events
    # => events except those with event name "new"
    
`select` and `reject` behave as you would expect, except they return a new filter instance.

You can also create a filter chain without supplying initial events, and apply that chain to any
array of events.

    filter = Filter.new.reject(events: "new")
    filter.apply(my_array_of_events)
    # => [ ... array ... ]
