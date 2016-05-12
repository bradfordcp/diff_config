class ConfLoader
  def self.load_config(path)
    config = {}
    File.open(path, 'r') do |io|
      matcher = /([a-z\.A-Z]*)\s*(.*)/
      io.each_line do |raw_line|
        line = raw_line.strip

        unless line[0] == '#'
          match_data = matcher.match line
          if match_data.length == 3
            config[match_data[1]] = match_data[2]
          else
            throw RuntimeError.new("Error parsing #{path}: #{parts}")
          end
        end
      end
    end
    config
  end
end
