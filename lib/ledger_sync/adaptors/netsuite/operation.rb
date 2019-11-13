# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
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

            def perform
              adaptor.setup
              ret = super
              adaptor.teardown
              ret
            end
          end
        end
      end
    end
  end
end
