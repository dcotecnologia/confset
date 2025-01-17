# frozen_string_literal: true

module Confset
  module Sources
    # Allows settings to be loaded from a "flat" hash with string keys, like ENV.
    class EnvSource
      attr_reader :prefix
      attr_reader :separator
      attr_reader :converter
      attr_reader :parse_values

      def initialize(env,
                     prefix: Confset.env_prefix || Confset.const_name,
                     separator: Confset.env_separator,
                     converter: Confset.env_converter,
                     parse_values: Confset.env_parse_values)
        @env = env
        @prefix = prefix.to_s.split(separator)
        @separator = separator
        @converter = converter
        @parse_values = parse_values
      end

      def load
        return {} if @env.nil? || @env.empty?

        hash = Hash.new

        @env.each do |variable, value|
          keys = variable.to_s.split(separator)

          next if keys.shift(prefix.size) != prefix

          keys.map! { |key|
            case converter
            when :downcase then
              key.downcase
            when nil then
              key
            else
              raise "Invalid ENV variables name converter: #{converter}"
            end
          }

          begin
            leaf = keys[0...-1].inject(hash) { |h, key| h[key] ||= {} }

            if leaf.is_a?(Hash)
              leaf[keys.last] = parse_values ? __value(value) : value
            else
              conflicting_key = (prefix + keys[0...-1]).join(separator)
              Confset.logger.error("Environment variable #{variable} conflicts with variable #{conflicting_key}")
            end
          rescue IndexError
            Confset.logger.warn("Wasn't possible to parse the env variable: #{variable}")
          end
        end

        hash
      end

      private
        # Try to convert string to a correct type
        def __value(v)
          case v
          when "false"
            false
          when "true"
            true
          else
            Integer(v) rescue Float(v) rescue v
          end
        end
    end
  end
end
