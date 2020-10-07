# frozen_string_literal: true

module LedgerSync
  class ResourceAdaptor
    module Mixin
      module ClassMethods
        def attribute(record_attribute, args = {})
          resource_attribute = args.fetch(:resource_attribute, record_attribute)

          attributes[record_attribute.to_sym] = {
            record_attribute: record_attribute,
            resource_attribute: resource_attribute
          }

          define_method(resource_attribute) do
            resource.send(record_attribute)
          end

          define_method("#{resource_attribute}=") do |*setter_args|
            resource.send("#{record_attribute}=", *setter_args)
          end
        end

        def attributes
          @attributes ||= {}
        end
      end

      module InstanceMethods
        def initialize(args = {})
          @resource = args.fetch(:resource).dup
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
        base.attr_reader(:resource)
        base.attribute(:ledger_id)
        base.attribute(:external_id)
        base.include(InstanceMethods)
      end
    end

    def initialize(*)
      raise NotImplementedError
    end

    def self.inherited(base)
      base.include(Mixin)

      super
    end
  end
end
