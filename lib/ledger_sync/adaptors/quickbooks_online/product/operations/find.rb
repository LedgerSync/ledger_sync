module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Product
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                optional(:description).maybe(:string)
                optional(:name).maybe(:string)
              end
            end

            private

            def operate
              return failure(nil) if resource.ledger_id.nil?

              response = @adaptor.find(
                resource: 'item',
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
