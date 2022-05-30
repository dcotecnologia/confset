# frozen_string_literal: true

require "confset/options"
require "confset/configuration"
require "confset/version"
require "confset/sources/yaml_source"
require "confset/sources/hash_source"
require "confset/sources/env_source"
require "confset/validation/schema"
require "deep_merge"

module Confset
  extend Confset::Validation::Schema
  extend Confset::Configuration.new(
    # general options
    const_name: "Settings",
    use_env: false,
    env_prefix: "Settings",
    env_separator: ".",
    env_converter: :downcase,
    env_parse_values: true,
    fail_on_missing: false,
    # deep_merge options
    knockout_prefix: nil,
    merge_nil_values: true,
    overwrite_arrays: true,
    merge_hash_arrays: false,
    validation_contract: nil,
    evaluate_erb_in_yaml: true
  )

  # Log information about the library.
  # Confset.logger.info("some info")
  # Documentation: https://ruby-doc.org/stdlib-3.1.2/libdoc/logger/rdoc/Logger.html
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new($stdout).tap do |log|
        log.progname = self.name
      end
    end
  end


  def self.setup
    yield self unless @_ran_once
    @_ran_once = true
  end

  # Create a populated Options instance from a settings file. If a second file is given, then the sections of that
  # file will overwrite existing sections of the first file.
  def self.load_files(*sources)
    config = Options.new

    # add settings sources
    [sources].flatten.compact.each do |source|
      config.add_source!(source)
    end

    config.add_source!(Sources::EnvSource.new(ENV)) if Confset.use_env

    config.load!
    config
  end

  # Loads and sets the settings constant!
  def self.load_and_set_settings(*sources)
    name = Confset.const_name
    Object.send(:remove_const, name) if Object.const_defined?(name)
    Object.const_set(name, Confset.load_files(sources))
  end

  def self.setting_files(config_root, env)
    [
      File.join(config_root, "settings.yml").to_s,
      File.join(config_root, "settings", "#{env}.yml").to_s,
      File.join(config_root, "environments", "#{env}.yml").to_s,
      *local_setting_files(config_root, env)
    ].freeze
  end

  def self.local_setting_files(config_root, env)
    [
      (File.join(config_root, "settings.local.yml").to_s if env != "test"),
      File.join(config_root, "settings", "#{env}.local.yml").to_s,
      File.join(config_root, "environments", "#{env}.local.yml").to_s
    ].compact
  end

  def self.reload!
    until Confset.const_name do
      const = Object.const_get(Confset.const_name)
      const.reload!
    end
  end
end

# Rails integration
require("confset/integrations/rails/railtie") if defined?(::Rails)

# Sinatra integration
require("confset/integrations/sinatra") if defined?(::Sinatra)
