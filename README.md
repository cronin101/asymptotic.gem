# asymptotic.gem

Create runtime-analysis graphs with minimal effort.

![](http://i.stack.imgur.com/Pd0zT.png)

## Installation

Add this line to your application's Gemfile:

    gem 'asymptotic'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install asymptotic

## Usage

```ruby
require 'asymptotic'

Asymptotic::Graph::plot("Data-Structure Element Retrieval Methods",

  "Checking if an element is in an array" => {
    function: ->(shuffled_array){ shuffled_array.include? 1 },
    input_seeds: (1..1000),
    input_function: ->(limit){ (1..limit*1000).to_a.shuffle }
  },

  "Checking if a key is in a hash" => {
    function: ->(hash){ hash.has_key? 'my key' },
    input_seeds: (1..1000),
    input_function: ->(limit){
      hash = {}.tap { |h|
        (limit*1000).times { |num| h[num] = 'some val' }
        h['my key'] = 'my val'
      }
    }
  }

)

```
![](http://i.imgur.com/sOYTOWh.png)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
