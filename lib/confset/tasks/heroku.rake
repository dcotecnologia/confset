# frozen_string_literal: true

require "confset/integrations/heroku"

namespace "confset" do
  task :heroku, [:app] => :environment do |_, args|
    Confset::Integrations::Heroku.new(args[:app]).invoke
  end
end
