# frozen_string_literal: true

require_relative '../reference'

# Reference attribute type for has_one
module LedgerSync
  class ResourceAttribute
    class Reference
      class Many < Reference
        class ManyArray
          include ActiveModel::Dirty

          ARRAY_METHODS_TO_OVERRIDE = %w[<< | []= + -].freeze

          attr_accessor :value

          define_attribute_methods :value

          def initialize
            @value = []
          end

          ARRAY_METHODS_TO_OVERRIDE.each do |array_method|
            define_method(array_method) do |val|
              value_will_change!
              @value = @value.send(array_method, val)
            end
          end
        end

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
            value: ManyArray.new
          )
        end

        def changed?
          pdb
          value.changed?
        end

        def changes
          pdb
          value.changes
        end

        def save
          value.save
          super
        end
      end
    end
  end
end
