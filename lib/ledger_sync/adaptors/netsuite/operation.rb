# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module NetSuite
      module Operation
        module Mixin
          def self.included(base)
            base.include Adaptors::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def ledger_resource_path
              adaptor.ledger_resource_path(resource: resource)
            end
          end
        end
      end
    end
  end
end
