module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module JournalEntry
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                optional(:currency).maybe(:string)
                optional(:memo).maybe(:string)
                optional(:transaction_date).filled(:date?)
                optional(:line_items).array(Types::Reference)
              end
            end

            private

            def operate
              return failure(nil) if resource.ledger_id.nil?

              response = adaptor.find(
                resource: 'journal_entry',
                id: resource.ledger_id
              )

              success(response: response)
            end
          end
        end
      end
    end
  end
end
