# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module LedgerSerializerType
        class AccountType < Adaptors::LedgerSerializerType::MappingType
          MAPPING = {
            'bank' => 'Bank',
            'other_current_assets' => 'Other Current Asset',
            'fixed_asset' => 'Fixed Asset',
            'other_asset' => 'Other Asset',
            'accounts_receivable' => 'Accounts Receivable',
            'equity' => 'Equity',
            'expense' => 'Expense',
            'other_expense' => 'Other Expense',
            'cost_of_goods_sold' => 'Cost of Goods Sold',
            'accounts_payable' => 'Accounts Payable',
            'credit_card' => 'Credit Card',
            'long_term_liability' => 'Long Term Liability',
            'other_current_liability' => 'Other Current Liability',
            'income' => 'Income',
            'other_income' => 'Other Income'
          }.freeze

          TYPE_TO_CLASSIFICATION_MAPPING = {
            'bank' => 'asset',
            'other_current_assets' => 'asset',
            'fixed_asset' => 'asset',
            'other_asset' => 'asset',
            'accounts_receivable' => 'asset',
            'equity' => 'equity',
            'expense' => 'expense',
            'other_expense' => 'expense',
            'cost_of_goods_sold' => 'expense',
            'accounts_payable' => 'liability',
            'credit_card' => 'liability',
            'long_term_liability' => 'liability',
            'other_current_liability' => 'liability',
            'income' => 'revenue',
            'other_income' => 'revenue'
          }

          def self.mapping
            @mapping ||= MAPPING
          end
        end
      end
    end
  end
end
