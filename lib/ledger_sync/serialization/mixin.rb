# frozen_string_literal: true

Gem.find_files('ledger_sync/type/**/*.rb').each { |path| require path }
require_relative 'attribute'
require_relative 'attribute_set_mixin'

module LedgerSync
  class Serialization
    module Mixin
      module ClassMethods
        #
        # Class method for defining de/serializer attributes
        #
        # @return [Serializer::Attribute]
        #
        def attribute(_hash_attribute, _args = {}, &_block)
          raise NotImplementedError
        end

        def attribute_class
          raise NotImplementedError
        end

        def attributes
          raise NotImplementedError
        end

        def references_many(args = {})
          _attribute(
            {
              type: Type::ReferencesManyType.new(serializer: self)
            }.merge(args)
          )
        end

        def references_one(args = {})
          _attribute(
            {
              type: Type::ReferencesOneType.new(serializer: self)
            }.merge(args)
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

          attribute_class.new(
            block: block,
            hash_attribute: hash_attribute,
            resource_attribute: resource_attribute,
            resource_class: resource_class,
            serializer: serializer,
            type: type
          )
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
