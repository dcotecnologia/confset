# frozen_string_literal: true

require "spec_helper"

module Confset::Sources
  describe EnvSource do
    context "configuration options" do
      before :each do
        Confset.reset
        Confset.env_prefix           = nil
        Confset.env_separator        = "."
        Confset.env_converter        = :downcase
        Confset.env_parse_values     = true
      end

      context "default configuration" do
        it "should use global prefix configuration by default" do
          Confset.env_prefix = "MY_CONFIG"

          source = EnvSource.new({ "MY_CONFIG.ACTION_MAILER" => "enabled" })
          results = source.load
          expect(results["action_mailer"]).to eq("enabled")
        end

        it "should use global separator configuration by default" do
          Confset.env_separator = "__"

          source = EnvSource.new({ "Settings__ACTION_MAILER__ENABLED" => "yes" })
          results = source.load
          expect(results["action_mailer"]["enabled"]).to eq("yes")
        end

        it "should use global converter configuration by default" do
          Confset.env_converter = nil

          source = EnvSource.new({ "Settings.ActionMailer.Enabled" => "yes" })
          results = source.load
          expect(results["ActionMailer"]["Enabled"]).to eq("yes")
        end

        it "should use global parse_values configuration by default" do
          Confset.env_parse_values = false

          source = EnvSource.new({ "Settings.ACTION_MAILER.ENABLED" => "true" })
          results = source.load
          expect(results["action_mailer"]["enabled"]).to eq("true")
        end
      end

      context "configuration overrides" do
        it "should allow overriding prefix configuration" do
          source = EnvSource.new({ "MY_CONFIG.ACTION_MAILER" => "enabled" },
                                 prefix: "MY_CONFIG")
          results = source.load
          expect(results["action_mailer"]).to eq("enabled")
        end

        it "should allow overriding separator configuration" do
          source = EnvSource.new({ "Settings__ACTION_MAILER__ENABLED" => "yes" },
                                 separator: "__")
          results = source.load
          expect(results["action_mailer"]["enabled"]).to eq("yes")
        end

        it "should allow overriding converter configuration" do
          source = EnvSource.new({ "Settings.ActionMailer.Enabled" => "yes" },
                                 converter: nil)
          results = source.load
          expect(results["ActionMailer"]["Enabled"]).to eq("yes")
        end

        it "should allow overriding parse_values configuration" do
          source = EnvSource.new({ "Settings.ACTION_MAILER.ENABLED" => "true" },
                                 parse_values: false)
          results = source.load
          expect(results["action_mailer"]["enabled"]).to eq("true")
        end
      end
    end
  end
end
