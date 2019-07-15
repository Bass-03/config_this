require "config/version"
# @author Edmundo Sanchez
# Configuration module
module Config
  class Error < StandardError; end
  # Get configuration
  # @return [Config] configuration
  def self.get
    @configuration ||= Configuration.new
  end
  # Set Configuration with a block
  # @param [Hash] Configuration Hash
  def self.set(config)
    @configuration = Configuration.new do |conf|
      config.each do |key,value|
        conf.instance_variable_set("@#{key}",value)
      end
    end
  end
  # Reset the configuration to an empty Configuration object
  def self.reset
    @configuration = Configuration.new
  end
  class Configuration
    # If block given, greate all instance variables
    # @return [Configuration] self
    def initialize
      yield(self) if block_given?
      return self
    end
    # Sets any un set instance variables
    def method_missing(method, *args, &block)
      attr_name = method.to_s.gsub("=","")
      self.class.send(:attr_accessor, attr_name) ## Ensure accesor is set
      # ensure correct behavior if accesor was not set, hence method was missing
      if self.instance_variable_defined?("@#{attr_name}")
        self.instance_variable_get("@#{attr_name}")
      else
        self.instance_variable_set("@#{attr_name}", args.first)
      end
    end
  end
