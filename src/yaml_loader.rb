require 'yaml'

class YAMLLoader
  def self.load_config(path)
    YAML.load_file path
  end
end
