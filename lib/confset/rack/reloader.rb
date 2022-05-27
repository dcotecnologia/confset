# frozen_string_literal: true

module Confset
  module Rack
    # Rack middleware the reloads Confset on every request (only use in dev mode)
    class Reloader
      def initialize(app)
        @app = app
      end

      def call(env)
        Confset.reload!
        @app.call(env)
      end
    end
  end
end
