# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module NetSuite
      class Operation
        module Mixin
          def self.included(base)
            base.include Ledgers::Operation::Mixin
            base.include InstanceMethods # To ensure these override parent methods
          end

          module InstanceMethods
            def ledger_resource_path(args = {})
              new_params = params.merge(args.fetch(:params, {}))
              client.ledger_resource_path(
                {
                  resource: resource
                }.merge(
                  args.merge(
                    params: new_params
                  )
                )
              )
            end

            def params
              {}
            end
          end
        end
      end
    end
  end
end
