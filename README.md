# Config

Have you ever wondered where is the right way to store sensitive information like passwords for your ruby scripts and gems?

I have, doing some research I found a few ways to create a class that will help set  configuration object for your script, but I would have to write it for every script I write, so I created this gem.

With **Config** you can load your configuration parameters from a YAML or json file, a block or a hash.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'config'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install config

## Usage

The Config Module is the main interface for this gem, as you know you can not instantiate a Module so be careful with your values

### Get the Configuration object

This will get the latest object you created.
``` ruby
Config.get
 => #<Config::Configuration:0x000055d538ef2dc0>
```

### Setting the configuration Object

If you plan on having only one configuration object you don't need to assign it, it will always return

``` ruby
Config.set(id:42, name: "Arthur Dent")
 => #<Config::Configuration:0x000055d538f3c9c0 @id=42, @name="Arthur Dent">
```

If you do plan to have multiple configurations, handle them properly

``` ruby
Config.set(id:42, name: "Arthur Dent")
 => #<Config::Configuration:0x000055d538f3c9c0 @id=42, @name="Arthur Dent">
number1 = Config.set(id:1, name: "Stefán Karl Stefánsson")
 => #<Config::Configuration:0x000055d53866ea00 @id=1, @name="Stefán Karl Stefánsson">
```

#### Setting it With a Hash

As you noticed, this is how you set it with a hash:
``` ruby
Config.set(id:42, name: "Arthur Dent")
 => #<Config::Configuration:0x000055d538f3c9c0 @id=42, @name="Arthur Dent">
```

### Setting it with a YAML file
``` ruby
Config.yaml_file("/absolute/path/file.yaml")
 => #<Config::Configuration:0x000055d538ed7d90 @id=42, @name="Arthur Dent", @weapon="Towel">
```

### Setting it with a JSON file
``` ruby
Config.json_file("/absolute/path/file.json")
 => #<Config::Configuration:0x000055d538a8f210 @id=42, @name="Arthur Dent", @weapon="Towel">
```

### Setting it with a Environmental Variables
Be sute the variables are set and accesible
``` ruby
ENV["id"] = "42"
ENV["name"] = "Arthur Dent"
Config.env_variables("id","name")
 => #<Config::Configuration:0x000055d538ef8b58 @id="42", @name="Arthur Dent">
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mundo03/config_me.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
