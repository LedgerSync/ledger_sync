# frozen_string_literal: true

require_relative '../reference'

# Reference attribute type for has_one
module LedgerSync
  class ResourceAttribute
    class Reference
      class Many < Reference
        module Mixin
          def self.included(base)
            base.extend(ClassMethods)
          end

          module ClassMethods
            def references_many(name, to:)
              resource_attribute = ResourceAttribute::Reference::Many.new(name: name, to: to)
              resource_attributes.add resource_attribute
              _define_attribute_methods(name)
            end
          end
        end

        def initialize(name:, to:)
          super(
            name: name,
            type: Type::ReferenceMany.new(resource_class: to),
            value: []
          )
        end
      end
    end
  end
end
