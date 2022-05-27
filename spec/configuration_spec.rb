# frozen_string_literal: true

require "spec_helper"

describe Confset::Configuration do
  subject do
    Module.new do
      extend Confset::Configuration.new(hello: "world")
    end
  end

  it "extends a module with additional methods" do
    expect(subject.hello).to eq("world")
    expect { subject.hello = "dlrow" }.to change { subject.hello }.to("dlrow")
  end
end
