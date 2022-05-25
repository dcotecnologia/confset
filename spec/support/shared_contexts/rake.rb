# frozen_string_literal: true

shared_context "rake" do
  # include rails rake tasks
  before do
    require "rake"
  end
end
