# frozen_string_literal: true

module LedgerSync
  module Adaptors
    class Adaptor
      include Fingerprintable::Mixin
      include SimplySerializable::Mixin
      include Validatable

      serialize only: %i[
        adaptor_configuration
      ]

      def initialize(*)
        raise NotImplementedError
      end

      def adaptor_configuration
        self.class.config
      end

      def base_module
        self.class.base_module
      end

      def ledger_attributes_to_save
        return {} if self.class.ledger_attributes_to_save.nil?

        Hash[self.class.ledger_attributes_to_save.map do |attribute|
          [attribute, send(attribute)]
        end]
      end

      def ledger_resource_type
        self.class.ledger_resource_type_for(resource_class: resource.class)
      end

      def operation_for(method:, resource:)
        self.class.operation_class_for(
          method: method,
          resource_class: resource.class
        ).new(
          adaptor: self,
          resource: resource
        )
      end

      def searcher_for?(resource_type:)
        searcher_class_for(resource_type: resource_type)
      rescue NameError
        false
      end

      def searcher_class_for(resource_type:)
        base_module.const_get(LedgerSync::Util::StringHelpers.camelcase(resource_type.to_s))::Searcher
      end

      def url_for(*_args)
        raise NotImplementedError
      end

      def parse_operation_error(*)
        nil
      end

      def self.base_module
        config.base_module
      end

      def self.base_operation_module_for(resource_class:)
        base_module.const_get("#{resource_class.resource_module_str}::Operations")
      end

      def self.config
        @config ||= LedgerSync.adaptors.config_from_class(adaptor_class: self)
      end

      # These are attributes that must always be saved after the adaptor is called.
      # For example, the library will handle refreshing tokens that will need
      # to be saved back to the application layer for future use.
      def self.ledger_attributes_to_save
        raise NotImplementedError
      end

      def self.ledger_resource_type_for(resource_class:)
        ledger_resource_type_overrides[resource_class] || resource_class.resource_type.to_s
      end

      def self.ledger_resource_type_overrides
        {}
      end

      def self.operation_class_for(method:, resource_class:)
        base_operation_module_for(resource_class: resource_class)
          .const_get(LedgerSync::Util::StringHelpers.camelcase(method.to_s))
      end

      def self.resource_from_ledger_type(type:, converter: nil)
        converter ||= Proc.new { |n| n.underscore }
        ledger_resource_type_overrides.invert[converter.call(type).to_sym] || LedgerSync.resources[converter.call(type).to_sym]
      end

      def self.url_for(resource: nil); end
    end
  end
end
