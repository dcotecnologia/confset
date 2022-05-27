# frozen_string_literal: true

require "spec_helper"
require "dry-validation"

describe Confset do
  context "validation" do
    around(:each) do |example|
      Confset.reset
      example.run
      Confset.reset
    end

    context "with validation_contract" do
      it "should raise if validation_contract is present and validation fails" do
        contract = Class.new(Dry::Validation::Contract)
        contract.params do
          required(:youtube).schema do
            required(:nonexist_field).filled
            required(:multiple_requirements).filled(:integer, gt?: 18)
          end
        end
        Confset.setup do |config|
          config.validation_contract = contract.new
        end

        msg = "Confset validation failed:\n\n"
        msg += "  youtube.nonexist_field: is missing\n"
        msg += "  youtube.multiple_requirements: must be an integer"

        expect { Confset.load_files("spec/fixtures/validation/confset.yml") }.
          to raise_error(Confset::Validation::Error, Regexp.new(msg))
      end

      it "should work if validation passes" do
        contract = Class.new(Dry::Validation::Contract)
        contract.params do
          required(:youtube).schema do
            required(:api_key).filled
          end
        end
        Confset.setup do |config|
          config.validation_contract = contract.new
        end

        expect { Confset.load_files("spec/fixtures/validation/confset.yml") }.
          to_not raise_error
      end
    end

    context "with schema" do
      it "should raise if schema is present and validation fails" do
        Confset.setup do |config|
          config.schema do
            required(:youtube).schema do
              required(:nonexist_field).filled
              required(:multiple_requirements).filled(:integer, gt?: 18)
            end
          end
        end

        msg = "Confset validation failed:\n\n"
        msg += "  youtube.nonexist_field: is missing\n"
        msg += "  youtube.multiple_requirements: must be an integer"

        expect { Confset.load_files("spec/fixtures/validation/confset.yml") }.
          to raise_error(Confset::Validation::Error, Regexp.new(msg))
      end

      it "should work if validation passes" do
        Confset.setup do |config|
          config.schema do
            required(:youtube).schema do
              required(:api_key).filled
            end
          end
        end

        expect { Confset.load_files("spec/fixtures/validation/confset.yml") }.
          to_not raise_error
      end
    end
  end
end
