module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module JournalEntry
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              schema do
                required(:ledger_id).filled(:string)
                optional(:currency).filled(:string)
                optional(:memo).filled(:string)
                optional(:transaction_date).filled(:date?)
                optional(:line_items).array(Types::Reference)
              end
            end

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'journal_entry',
                id: resource.ledger_id
              )
              response = adaptor.post(
                resource: 'journal_entry',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            end

            def local_resource_data
              {
                'CurrencyRef' => {
                  'value' => resource.currency,
                },
                'TxnDate' => resource.transaction_date.to_s, # Format: YYYY-MM-DD
                'PrivateNote' => resource.memo,
                'Line' => resource.line_items.map do |line_item|
                  {
                    'DetailType' => 'JournalEntryLineDetail',
                    'JournalEntryLineDetail' => {
                      'PostingType': Mapping::LINE_ITEM_TYPES[line_item.entry_type],
                      'AccountRef' => {
                        'value' => line_item.account&.ledger_id
                      }
                    },
                    'Amount' => line_item.amount / 100.0,
                    'Description' => line_item.description
                  }
                end
              }
            end
          end
        end
      end
    end
  end
end
