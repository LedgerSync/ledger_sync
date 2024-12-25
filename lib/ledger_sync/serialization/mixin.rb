# frozen_string_literal: true

Gem.find_files('ledger_sync/type/**/*.rb').each { |path| require path }
require_relative 'attribute'
require_relative 'attribute_set_mixin'
require_relative '../ledgers/mixins/infer_serializer_mixin'

module LedgerSync
  module Serialization
    module Mixin
      module ClassMethods
        #
        # Class method for defining de/serializer attributes
        #
        # @return [Serializer::Attribute]
        #
        def attribute(_hash_attribute, _args = {}, &)
          raise NotImplementedError
        end

        def attribute_class
          raise NotImplementedError
        end

        def attributes
          raise NotImplementedError
        end

        def mapping(destination_attribute, args = {})
          attribute(
            destination_attribute,
            {
              type: Type::MappingType.new(hash: args.fetch(:hash))
            }.merge(args.except(:hash))
          )
        end

        def _attribute(args)
          attributes.add(_build_attribute(args))
        end

        def _build_attribute(args)
          block              = args.fetch(:block, nil)
          hash_attribute     = args.fetch(:hash_attribute, nil)
          resource_attribute = args.fetch(:resource_attribute, nil)
          resource_class     = args.fetch(:resource_class, nil)
          serializer         = args.fetch(:serializer, nil)
          type               = args.fetch(:type, nil)
          if_method          = args.fetch(:if, nil)

          attribute_class.new(
            block: block,
            hash_attribute: hash_attribute,
            if: if_method,
            resource_attribute: resource_attribute,
            resource_class: resource_class,
            serializer: serializer,
            type: type
          )
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
        base.include(LedgerSync::Ledgers::Mixins::InferSerializerMixin)
        base.include(SimplySerializable::Mixin)
      end
    end
  end
end
