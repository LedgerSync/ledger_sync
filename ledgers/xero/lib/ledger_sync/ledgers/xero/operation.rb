# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Xero
      class Operation
        module Mixin
          def self.included(base)
            base.include Ledgers::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def deserialized_resource(response:)
              deserializer.deserialize(
                hash: response,
                resource: resource
              )
            end

            def ledger_resource_path
              @ledger_resource_path ||= "#{ledger_resource_type_for_path}/#{resource.ledger_id}"
            end

            def ledger_resource_type_for_path
              xero_resource_type.pluralize
            end

            def response_to_operation_result(response:)
              if response.success?
                success(
                  resource: deserialized_resource(
                    response: response.body.dig(
                      ledger_resource_type_for_path.to_s.capitalize
                    )&.first
                  ),
                  response: response
                )
              else
                failure(
                  # implement
                )
              end
            end

            def perform
              super
            rescue LedgerSync::Error::OperationError, OAuth2::Error => e
              failure(e)
            end

            def xero_resource_type
              @xero_resource_type ||= client.class.ledger_resource_type_for(resource_class: resource.class)
            end
          end
        end
      end
    end
  end
end
