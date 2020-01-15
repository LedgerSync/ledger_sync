# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Operation
        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def deserialized_resource(response:)
              ledger_serializer.deserialize(
                hash: response.body.dig(
                  quickbooks_online_resource_type.to_s.classify
                )
              )
            end

            def ledger_resource_path
              @ledger_resource_path ||= "#{ledger_resource_type_for_path}/#{resource.ledger_id}"
            end

            def ledger_resource_type_for_path
              quickbooks_online_resource_type.tr('_', '')
            end

            def result(response:)
              if response.success?
                success(
                  resource: deserialized_resource(response: response),
                  response: response
                )
              else
                failure(
                  Error::OperationError.new(
                    operation: self,
                    response: response
                  )
                )
              end
            end

            def perform
              super
            rescue OAuth2::Error => e
              failure(e)
            end

            def quickbooks_online_resource_type
              @quickbooks_online_resource_type ||= ledger_serializer.class.quickbooks_online_resource_type
            end
          end
        end
      end
    end
  end
end
