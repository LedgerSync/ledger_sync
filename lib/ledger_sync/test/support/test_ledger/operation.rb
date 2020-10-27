# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module TestLedger
      class Operation
        module Mixin
          def self.included(base)
            base.include Ledgers::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def deserialized_resource(response:)
              deserializer.deserialize(
                hash: response.body[test_ledger_resource_type.to_s.camelize],
                resource: resource
              )
            end

            def ledger_resource_path
              @ledger_resource_path ||= "#{ledger_resource_type_for_path}/#{resource.ledger_id}"
            end

            def ledger_resource_type_for_path
              test_ledger_resource_type.tr('_', '')
            end

            def response_to_operation_result(response:)
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

            def test_ledger_resource_type
              @test_ledger_resource_type ||= client.class.ledger_resource_type_for(resource_class: resource.class)
            end
          end
        end
      end
    end
  end
end
