# frozen_string_literal: true

require "confset/validation/error"

module Confset
  module Validation
    module Validate
      def validate!
        validate_using!(Confset.validation_contract)
        validate_using!(Confset.schema)
      end

      private
        def validate_using!(validator)
          if validator
            result = validator.call(to_hash)

            return if result.success?

            error = Confset::Validation::Error.format(result)
            raise Confset::Validation::Error, "Confset validation failed:\n\n#{error}"
          end
        end
    end
  end
end
