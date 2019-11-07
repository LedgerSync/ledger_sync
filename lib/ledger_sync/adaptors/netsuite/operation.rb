# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Operation
        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
          end

          def netsuite_resource_class
            @netsuite_resource_class ||= ledger_serializer.class::NETSUITE_RESOURCE_CLASS
          end
        end
      end
    end
  end
end
