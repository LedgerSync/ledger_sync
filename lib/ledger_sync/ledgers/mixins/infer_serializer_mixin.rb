# frozen_string_literal: true

require_relative 'infer_config_mixin'
require_relative 'infer_resource_class_mixin'

module LedgerSync
  module Ledgers
    module Mixins
      module InferSerializerMixin
        module ClassMethods
          def inferred_deserializer_class
            @inferred_deserializer_class ||= inferred_config.base_module.const_get(
              inferred_deserializer_class_name
            )
          end

          def inferred_deserializer_class_name
            @inferred_deserializer_class_name ||= "#{inferred_resource_class.resource_module_str}::Deserializer"
          end

          def inferred_searcher_deserializer_class
            @inferred_searcher_deserializer_class ||= inferred_config.base_module.const_get(
              inferred_searcher_deserializer_class_name
            )
          end

          def inferred_searcher_deserializer_class_name
            @inferred_searcher_deserializer_class_name ||= begin
              "#{inferred_resource_class.resource_module_str}::SearcherDeserializer"
            end
          end

          def inferred_serializer_class
            @inferred_serializer_class ||= begin
              inferred_config.base_module.const_get(
                inferred_serializer_class_name
              )
            end
          end

          def inferred_serializer_class_name
            @inferred_serializer_class_name ||= "#{inferred_resource_class.resource_module_str}::Serializer"
          end
        end

        def self.included(base)
          base.include InferConfigMixin
          base.include InferResourceClassMixin
          base.extend ClassMethods
        end
      end
    end
  end
end
