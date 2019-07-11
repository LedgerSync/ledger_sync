module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Invoice
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:currency).maybe(:string)
                required(:customer).maybe(Types::Reference)
                required(:line_items).maybe(:array)
                required(:number).maybe(:integer)
              end
            end

            private

            def operate
              return failure(nil) if resource.ledger_id.nil?

              response = adaptor.find(
                resource: 'invoice',
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
