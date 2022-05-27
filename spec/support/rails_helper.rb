# frozen_string_literal: true

##
# Confset Rspec Helpers
#

# Loads ENV vars from a yaml file
def load_env(filename)
  if filename && File.exist?(filename.to_s)
    result = YAML.load(ERB.new(IO.read(filename.to_s)).result)
  end
  result.each { |key, value| ENV[key.to_s] = value.to_s } unless result.nil?
end

# Checks if (default) Confset const is already available
def config_available?
  where = caller[0].split(":")[0].gsub(File.expand_path(File.dirname(__FILE__)), "")

  if defined?(::Settings)
    puts "Confset available in #{where}"
  else
    raise "Confset not available in #{where}"
  end
end
