# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module SerializationMixin
        module ClassMethods
          def inferred_deserializer_class
            @inferred_deserializer_class ||= inferred_serialization_class(type: 'Deserializer')
          end

          def inferred_serialization_class(args = {})
            type = args.fetch(:type)

            inferred_config.base_module.const_get(
              "#{inferred_resource_class}::#{type.camelcase}"
            )
          end

          def inferred_serializer_class
            @inferred_serializer_class ||= inferred_serialization_class(type: 'Serializer')
          end
        end

        def self.included(base)
          base.include InferConfigMixin
          base.include InferResourceClassMixin
          base.extend ClassMethods
        end

        def deserializer
          self.class.inferred_deserializer_class.new
        end

        def serializer
          self.class.inferred_serializer_class.new
        end
      end
    end
  end
end
