# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuiteSOAP
      class Operation
        module Mixin
          def self.included(base)
            base.include Ledgers::Operation::Mixin
            base.include InstanceMethods
          end

          module InstanceMethods
            def netsuite_resource_class
              @netsuite_resource_class ||= serializer.class::NETSUITE_RESOURCE_CLASS
            end

            def netsuite_error(netsuite_resource:)
              Error::OperationError.new(
                message: netsuite_resource.errors.first.message,
                operation: self,
                response: netsuite_resource
              )
            end

            def netsuite_failure(netsuite_resource:)
              failure(netsuite_error(netsuite_resource: netsuite_resource))
            end

            def perform
              client.wrap_perform do
                super
              end
            end
          end
        end
      end
    end
  end
end
