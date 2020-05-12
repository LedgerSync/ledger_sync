# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      module Operation
        module Mixin
          def self.included(base)
            base.include Ledgers::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def ledger_resource_path
              connection.ledger_resource_path(resource: resource)
            end
          end
        end
      end
    end
  end
end
