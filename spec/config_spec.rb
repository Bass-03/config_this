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
end
