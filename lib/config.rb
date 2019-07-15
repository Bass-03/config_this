require "config/version"
require "yaml"
require "json"

# @author Edmundo Sanchez
# Configuration module
module Config
  # Error Class
  class Error < StandardError; end
  # Get configuration
  # @return [Configuration] configuration
  def self.get
    @configuration ||= Configuration.new
  end
  # Set Configuration with a block
  # @param config [Hash] Configuration Hash
  # @return [Configuration] configuration
  def self.set(config)
    @configuration = Configuration.new do |conf|
      config.each do |key,value|
        conf.instance_variable_set("@#{key}",value)
      end
    end
  end
  # Reset the configuration to an empty Configuration object
  # @return [Configuration] configuration
  def self.reset
    @configuration = Configuration.new
  end
  # Read YAML file and set configuration
  # @param path [String] Absolute Path to Yaml file
  # @return [Configuration] configuration
  def self.yaml_file(path)
    self.set YAML.load_file(path)
  end
  # Read JSON file and set configuration
  # @param path [String] Absolute Path to Yaml file
  # @return [Configuration] configuration
  def self.json_file(path)
    file = File.read(path)
    self.set JSON.parse(file)
  end
  # Read Environmental Variables and set configuration
  # @note All values will be strings by definition
  # @param variables [Array] List of Environmental variables
  # @return [Configuration] configuration
  def self.env_variables(*variables)
    variables.map! do |var|
      [var,ENV[var]]
    end
    self.set(Hash[*variables.flatten])
  end

  # Template for the Configuration object
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
end
