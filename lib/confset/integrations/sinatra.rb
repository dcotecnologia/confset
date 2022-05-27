# frozen_string_literal: true

require "confset/rack/reloader"

module Confset
  # provide helper to register within your Sinatra app
  #
  # set :root, File.dirname(__FILE__)
  # register Confset
  #
  def self.registered(app)
    app.configure do |inner_app|
      env = inner_app.environment || ENV["RACK_ENV"]
      root = inner_app.root

      # use Padrino settings if applicable
      if defined?(Padrino)
        env = Padrino.env if Padrino.respond_to?(:env)
        root = Padrino.root if Padrino.respond_to?(:root)
      end

      Confset.load_and_set_settings(Confset.setting_files(File.join(root, "config"), env))

      inner_app.use(::Confset::Rack::Reloader) if inner_app.development?
    end
  end
end
