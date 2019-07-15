RSpec.describe Config do
  it "has a version number" do
    expect(ConfigMe::VERSION).not_to be nil
  end

  context "Config::Configuration class" do
    it "Can be created with no instance variables" do
      config = Config::Configuration.new
      expect(config.instance_variables).to eq []
    end

    it "Can be created with an instance variables" do
      var_name = "@test"
      config = Config::Configuration.new do |conf|
        conf.instance_variable_set(var_name,var_name)
      end
      expect(config.instance_variable_defined?(var_name)).to be true
    end
  end

  context "Config Module" do
    it "Can get an Empty Configuration object" do
      expect(Config.get).to be_instance_of Config::Configuration
    end

    it "Can set an Empty Configuration object" do
      expect(Config.set({})).to be_instance_of Config::Configuration
    end

    it "Can set a non-Empty Configuration object" do
      expect(Config.set({:id=>42})).to be_instance_of Config::Configuration
    end

    it "Can set a non-Empty Configuration object, check value" do
      Config.set({"id"=>42})
      expect(Config.get.id).to eq 42
    end

    it "Can set reset to empy Configuration object" do
      Config.set({"id"=>42})
      Config.reset
      expect(Config.get.instance_variables).to eq []
    end

  end

end
