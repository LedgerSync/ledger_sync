module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:name).maybe(:string)
                required(:account_type).maybe(:string)
              end
            end

            private

            def operate
              return failure(nil) if resource.ledger_id.nil?

              response = @adaptor.find(
                resource: 'account',
                id: resource.ledger_id
              )

              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end
          end
        end
      end
    end
  end
end
