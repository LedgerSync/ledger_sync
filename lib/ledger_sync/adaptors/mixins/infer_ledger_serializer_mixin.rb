# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Mixins
      module InferLedgerSerializerMixin
        module ClassMethods
          def inferred_ledger_serializer(resource:)
            inferred_ledger_serializer_class.new(
              resource: resource
            )
          end

          def inferred_ledger_serializer_class
            inferred_adaptor_class.base_module.const_get(
              "#{inferred_resource_class.resource_module_str}::LedgerSerializer"
            )
          end
        end

        def self.included(base)
          base.include InferAdaptorClassMixin
          base.include InferResourceClassMixin
          base.extend ClassMethods
        end
      end
    end
  end
end
