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

          define_method(record_attribute) do
            resource.send(resource_attribute)
          end

          define_method("#{record_attribute}=") do |*setter_args|
            resource.send("#{resource_attribute}=", *setter_args)
          end
        end

        def attributes
          @attributes ||= {}
        end

        def references_one(record_attribute, args = {})
          resource_attribute = args.fetch(:resource_attribute, record_attribute)
          adaptor_class      = args.fetch(:adaptor_class)

          attributes[record_attribute.to_sym] = {
            adaptor_class: adaptor_class,
            record_attribute: record_attribute,
            resource_attribute: resource_attribute
          }

          define_method(record_attribute) do
            adaptor_class.new(
              resource: resource,
              dup: false
            )
          end
        end

        def inferred_client_base_module
          @inferred_client_base_module ||= inferred_client_class.base_module
        end

        def inferred_client_class
          @inferred_client_class ||= begin
            return if name.nil?

            parts = name.split('::')
            return unless parts.include?('Adaptors')

            LedgerSync::Ledgers.const_get(
              parts[parts.index('Adaptors') + 1]
            )::Client
          end
        end
      end

      module InstanceMethods
        def initialize(args = {})
          dup = args.fetch(:dup, true)

          @resource = args.fetch(:resource)
          @resource = @resource.dup if dup
        end

        def resource_class(type)
          self.class.inferred_client_class.resources[type]
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
    end
  end
end
