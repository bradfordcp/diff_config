class PropertiesLoader
  def self.load_config(path)
    config = {}
    File.open(path, 'r') do |io|
      io.each_line do |raw_line|
        line = raw_line.strip

        unless line[0] == '#'
          if parts.length == 2
            config[parts[0]] = parts[1]
          else
            throw RuntimeError.new("Error parsing #{path}: #{parts}")
          end
        end
      end
    end
    config
  end
end