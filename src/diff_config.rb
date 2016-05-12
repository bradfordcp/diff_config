require_relative 'yaml_loader'
require_relative 'properties_loader'
require_relative 'conf_loader'

class DiffConfig
  def initialize(options)
    # Capture interesting options
    # @ignore_config_comments = options[:ignore_config_comments]

    # Verify source exists, then load it
    if File.exists? options[:source]
      @source = options[:source]

      puts "Loading source file #{@source}"
      @source_config = load_config(@source)
    else
      throw ArgumentError.new("Source file #{options[:source]} not found. Verify it exists and try again.")
    end

    # Determine targets for comparison
    @targets = []
    Dir.glob options[:target] do |path|
      @targets << path
    end

    # Store a whitelist of keys that we expect to be different
    @whitelist_keys = options[:whitelist_keys]
    puts "Whitelist Keys #{@whitelist_keys}"
  end

  def load_config(path)
    case File.extname(path)
    when '.yaml'
      YAMLLoader.load_config path
    when '.properties'
      PropertiesLoader.load_config path
    when '.conf'
      ConfLoader.load_config path
    else
      {}
    end
  end

  def diff
    @targets.each do |target|
      puts '##############################################'
      puts "Loading target file #{target}:"
      puts '----------------------------------------------'
      target_config = load_config(target)

      diff_hash('', @source_config, target_config)
    end
  end

  def diff_hash(id, left, right)
    # First compare all values in source_tree to target_tree
    left.each_pair do |key, value|
      # Verify key exists in target
      if right.key? key
        case
        when value.is_a?(Hash)
          diff_hash("#{id}:#{key}", value, right[key])
        when value.is_a?(Array)
          diff_array(key, value, right[key])
        else
          diff_value(key, value, right[key])
        end
      else
        unless @whitelist_keys.include? key
          puts "Key #{key}: missing"
          puts "  expected: #{value}"
        end
      end
    end

    # Identify any keys in target that are not present in source
    (right.keys - left.keys).each do |key|
      unless @whitelist_keys.include? key
        puts "Key #{id}:"
        puts "  extra value: {#{key}: #{right[key]}}"
      end
    end
  end

  def diff_array(id, left, right)
    left.each do |value|
      unless right.include? value
        puts "Key #{id} different:"
        puts "  missing expected value: #{value}"
      end
    end

    (right - left).each do |value|
      unless @whitelist_keys.include? id
        puts "Key #{id} different:"
        puts "  extra value: #{value}"
      end
    end
  end

  def diff_value(id, left, right)
    unless left == right || @whitelist_keys.include?(id)
      puts "Key #{id} different:"
      puts "  expected: #{left}"
      puts "  actual:   #{right}"
    end
  end
end
