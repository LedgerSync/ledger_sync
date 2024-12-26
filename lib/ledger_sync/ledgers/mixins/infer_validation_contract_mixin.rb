# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module InferValidationContractMixin
        module ClassMethods
          def inferred_validation_contract_class
            @inferred_validation_contract_class ||= const_get(
              inferred_validation_contract_class_name
            )
          end

          def inferred_validation_contract_class_name
            @inferred_validation_contract_class_name ||= "#{name}::Contract"
          end
        end

        def self.included(base)
          base.extend ClassMethods
        end
      end
    end
  end
end
