# frozen_string_literal: true

require_relative '../reference'

# Reference attribute type for has_one
module LedgerSync
  class ResourceAttribute
    class Reference
      class One < Reference
        module Mixin
          def self.included(base)
            base.extend(ClassMethods)
          end

          module ClassMethods
            def references_one(name, to:)
              resource_attribute = ResourceAttribute::Reference::One.new(
                name: name,
                resource_class: self,
                to: to
              )
              resource_attributes.add resource_attribute
              _define_attribute_methods(name)
            end
          end
        end

        def initialize(args = {})
          to = args.fetch(:to)
          super(
            args.except(:to).merge(
              type: Type::ReferenceOne.new(resource_class: to)
            )
          )
        end
      end
    end
  end
end
