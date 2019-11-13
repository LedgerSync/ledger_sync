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

      def searcher_for?(resource_type:)
        searcher_klass_for(resource_type: resource_type)
      rescue NameError
        false
      end

      def searcher_klass_for(resource_type:)
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
        @config ||= LedgerSync.adaptors.config_from_klass(klass: self)
      end

      # These are attributes that must always be saved after the adaptor is called.
      # For example, the library will handle refreshing tokens that will need
      # to be saved back to the application layer for future use.
      def self.ledger_attributes_to_save
        raise NotImplementedError
      end

      def self.url_for(resource: nil); end
    end
  end
end
