# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"

require "confset"
require "pry"

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Turn the deprecation warnings into errors, giving you the full backtrace
  config.raise_errors_for_deprecations!

  config.before(:suite) do
    Confset.module_eval do
      # Extend Confset module with ability to reset configuration to the default values
      def self.reset
        self.const_name           = "Settings"
        self.use_env              = false
        self.knockout_prefix      = nil
        self.overwrite_arrays     = true
        self.schema               = nil
        self.validation_contract  = nil
        self.fail_on_missing      = false
        instance_variable_set(:@_ran_once, false)
      end
    end
  end
end
