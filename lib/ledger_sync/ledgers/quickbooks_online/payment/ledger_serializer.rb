# frozen_string_literal: true

require_relative '../currency/ledger_serializer'
require_relative '../payment_line_item/ledger_serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      module Payment
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          id

          attribute ledger_attribute: 'TotalAmt',
                    resource_attribute: :amount,
                    type: LedgerSerializerType::AmountType

          references_one ledger_attribute: :CurrencyRef,
                         resource_attribute: :currency,
                         serializer: Currency::LedgerSerializer

          attribute ledger_attribute: 'CustomerRef.value',
                    resource_attribute: 'customer.ledger_id'

          attribute ledger_attribute: 'DepositToAccountRef.value',
                    resource_attribute: 'deposit_account.ledger_id'

          attribute ledger_attribute: 'ARAccountRef.value',
                    resource_attribute: 'account.ledger_id'

          attribute ledger_attribute: 'PaymentRefNum',
                    resource_attribute: :reference_number

          attribute ledger_attribute: 'PrivateNote',
                    resource_attribute: :memo

          attribute ledger_attribute: 'ExchangeRate',
                    resource_attribute: :exchange_rate

          attribute ledger_attribute: 'TxnDate',
                    resource_attribute: :transaction_date,
                    type: LedgerSerializerType::DateType

          references_many ledger_attribute: 'Line',
                          resource_attribute: :line_items,
                          serializer: PaymentLineItem::LedgerSerializer
        end
      end
    end
  end
end
