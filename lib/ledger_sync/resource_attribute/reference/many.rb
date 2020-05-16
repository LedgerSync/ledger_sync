# frozen_string_literal: true

require_relative '../reference'

# Reference attribute type for has_one
module LedgerSync
  class ResourceAttribute
    class Reference
      class Many < Reference
        class ManyArray < Array
          include ActiveModel::Dirty

          ARRAY_METHODS_TO_OVERRIDE_WITH_DIRTY = %w[<< | []= + -].freeze

          define_attribute_methods :value

          ARRAY_METHODS_TO_OVERRIDE_WITH_DIRTY.each do |array_method|
            define_method(array_method) do |val|
              value_will_change!
              super(val)
            end
          end

          def ==(other)
            return false unless other.is_a?(ManyArray) || other.is_a?(Array)
            return false unless sorted_fingerprints(other) == sorted_fingerprints

            true
          end

          def save
            changes_applied
          end

          def sorted_fingerprints(other = nil)
            (other || self).map(&:fingerprint).sort
          end

          def value
            self
          end
        end

        module Mixin
          def self.included(base)
            base.extend(ClassMethods)
          end

          module ClassMethods
            def references_many(name, to:)
              resource_attribute = ResourceAttribute::Reference::Many.new(
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
              type: Type::ReferenceMany.new(resource_class: to),
              value: ManyArray.new
            )
          )
        end

        def changed?
          value.changed?
        end

        def changes
          value.changes
        end

        def save
          value.save
        end
      end
    end
  end
end
