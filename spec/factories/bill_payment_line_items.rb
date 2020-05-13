# frozen_string_literal: true

FactoryBot.define do
  factory :bill_payment_line_item, class: LedgerSync::Bundles::ModernTreasury::BillPaymentLineItem do
    references_many :ledger_transactions, factory: :bill

    amount { 100 }
  end
end
