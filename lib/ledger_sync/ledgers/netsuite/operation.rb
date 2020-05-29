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
            def request_params
              {}
            end

            def ledger_id
              @ledger_id ||= Util::URLHelpers.id_from_url(url: response.headers['Location'])
            end

            def ledger_resource_path(args = {})
              client.ledger_resource_path(
                {
                  resource: resource
                }.merge(
                  args.merge(
                    params: request_params.merge(
                      args.fetch(:params, {})
                    )
                  )
                )
              )
            end
          end
        end
      end
    end
  end
end
