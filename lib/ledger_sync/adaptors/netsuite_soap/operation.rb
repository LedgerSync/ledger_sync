# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuiteSOAP
      module Operation
        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
            base.include InstanceMethods
          end

          module InstanceMethods
            def netsuite_resource_class
              @netsuite_resource_class ||= ledger_serializer.class::NETSUITE_RESOURCE_CLASS
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
              adaptor.wrap_perform do
                super
              end
            end
          end
        end
      end
    end
  end
end
