# frozen_string_literal: true

module Confset
  module Integrations
    module Rails
      class Railtie < ::Rails::Railtie
        def preload
          # Manually load the custom initializer before everything else
          initializer = ::Rails.root.join("config", "initializers", "confset.rb")
          require initializer if File.exist?(initializer)

          # Parse the settings before any of the initializers
          Confset.load_and_set_settings(
            Confset.setting_files(::Rails.root.join("config"), ::Rails.env)
          )
        end

        # Load rake tasks (eg. Heroku)
        rake_tasks do
          Dir[File.join(File.dirname(__FILE__), "../tasks/*.rake")].each { |f| load f }
        end

        config.before_configuration { preload }

        # Development environment should reload settings on every request
        if ::Rails.env.development?
          initializer :config_reload_on_development do
            ActiveSupport.on_load :action_controller_base do
              if ::Rails::VERSION::MAJOR >= 4
                prepend_before_action { ::Confset.reload! }
              else
                prepend_before_filter { ::Confset.reload! }
              end
            end
          end
        end
      end
    end
  end
end
