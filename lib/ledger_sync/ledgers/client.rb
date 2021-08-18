# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Client
      module SharedClassMethods
        def base_operations_module_for(resource_class:)
          resource_class::Operations
        end
      end

      extend SharedClassMethods

      module Mixin
        module InstanceMethods
          def base_module
            self.class.base_module
          end

          def update_secrets_in_dotenv
            return if ENV['TEST_ENV'] && !ENV['USE_DOTENV_ADAPTOR_SECRETS']

            Util::DotenvUpdator.new.update(client: self)
          end

          def ledger_configuration
            self.class.config
          end

          def ledger_attributes_to_save
            return {} if self.class.ledger_attributes_to_save.nil?

            Hash[self.class.ledger_attributes_to_save.map do |attribute|
              [attribute, send(attribute)]
            end]
          end

          def operation_for(args = {})
            method = args.fetch(:method)
            resource = args.fetch(:resource)

            self.class.operation_class_for(
              method: method,
              resource_class: resource.class
            ).new(
              client: self,
              resource: resource
            )
          end

          def searcher_for(resource_type:, query: '')
            self.class.searcher_for(
              resource_type: resource_type,
              client: self,
              query: query
            )
          end

          def searcher_class_for(*args, **keywords)
            self.class.searcher_class_for(*args, **keywords)
          end

          def url_for(*_args)
            raise NotImplementedError
          end

          def parse_operation_error(*)
            nil
          end
        end

        module ClassMethods
          def base_module
            config.base_module
          end

          def config
            @config ||= LedgerSync.ledgers.config_from_class(client_class: self)
          end

          # These are attributes that must always be saved after the client is called.
          # For example, the library will handle refreshing tokens that will need
          # to be saved back to the application layer for future use.
          def ledger_attributes_to_save
            raise NotImplementedError
          end

          def ledger_resource_type_for(resource_class:)
            ledger_resource_type_overrides[resource_class] || resource_class.resource_type.to_s
          end

          def ledger_resource_type_overrides
            {}
          end

          def operation_class_for(*args, **keywords)
            Client.operation_class_for(*args, **keywords)
          end

          def resource_from_ledger_type(type:, converter: nil)
            converter ||= proc { |n| n.underscore }
            ledger_resource_type_overrides.invert[converter.call(type).to_sym] || resources[converter.call(type).to_sym]
          end

          def resources
            @resources ||= {}
          end

          def root_key
            @root_key ||= config.root_key
          end

          def searcher_for(resource_type:, client:, query: '')
            searcher_class_for(resource_type: resource_type).new(client: client, query: query)
          end

          def searcher_class_for(resource_type:)
            base_module.const_get(LedgerSync::Util::StringHelpers.camelcase(resource_type.to_s))::Searcher
          end

          def url_for(resource: nil); end
        end

        def self.included(base)
          base.include Fingerprintable::Mixin
          base.include SimplySerializable::Mixin
          base.include Validatable
          base.include Util::Mixins::ResourceRegisterableMixin
          base.extend SharedClassMethods
          base.extend ClassMethods
          base.include InstanceMethods

          base.simply_serialize only: %i[
            ledger_configuration
          ]
        end
      end

      def self.operation_class_for(method:, resource_class:)
        base_operations_module_for(resource_class: resource_class)
          .const_get(LedgerSync::Util::StringHelpers.camelcase(method.to_s))
      end
    end
  end
end
