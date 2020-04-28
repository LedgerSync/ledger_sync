# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Mixins
      module InferLedgerSerializerMixin
        module ClassMethods
          def inferred_ledger_deserializer_class
            @inferred_ledger_deserializer_class ||= begin
              inferred_adaptor_class.base_module.const_get(
                inferred_ledger_deserializer_class_name
              )
            rescue NameError
              inferred_adaptor_class.base_module.const_get(
                inferred_ledger_serializer_class_name
              )
            end
          end

          def inferred_ledger_deserializer_class_name
            @inferred_ledger_deserializer_class_name ||= "#{inferred_resource_class.resource_module_str}::LedgerDeserializer"
          end

          def inferred_ledger_searcher_deserializer_class
            @inferred_ledger_searcher_deserializer_class ||= begin
              inferred_adaptor_class.base_module.const_get(
                inferred_ledger_searcher_deserializer_class_name
              )
            rescue NameError
              inferred_adaptor_class.base_module.const_get(
                inferred_ledger_serializer_class_name
              )
            end
          end

          def inferred_ledger_searcher_deserializer_class_name
            @inferred_ledger_searcher_deserializer_class_name ||= "#{inferred_resource_class.resource_module_str}::LedgerSearcherDeserializer"
          end

          def inferred_ledger_serializer_class
            @inferred_ledger_serializer_class ||= begin
              inferred_adaptor_class.base_module.const_get(
                inferred_ledger_serializer_class_name
              )
            end
          end

          def inferred_ledger_serializer_class_name
            @inferred_ledger_serializer_class_name ||= "#{inferred_resource_class.resource_module_str}::LedgerSerializer"
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
