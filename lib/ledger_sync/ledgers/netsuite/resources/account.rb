# frozen_string_literal: true

require_relative 'currency'

module LedgerSync
  module Ledgers
    module NetSuite
      class Account < NetSuite::Resource
        TYPES = {
          'bank' => 'Bank',
          'other_current_assets' => 'OthCurrAsset',
          'fixed_asset' => 'FixedAsset',
          'other_asset' => 'OthAsset',
          'accounts_receivable' => 'AcctRec',
          'equity' => 'Equity',
          'expense' => 'Expense',
          'other_expense' => 'OthExpense',
          'cost_of_goods_sold' => 'COGS',
          'accounts_payable' => 'AcctPay',
          'credit_card' => 'CredCard',
          'long_term_liability' => 'LongTermLiab',
          'other_current_liability' => 'OthCurrLiab',
          'income' => 'Income',
          'other_income' => 'OthIncome',
          'deferred_expense' => 'DeferExpense',
          'unbilled_recievable' => 'UnbilledRec',
          'deferred_revenue' => 'DeferRevenue',
          'non_posting' => 'NonPosting'
        }.freeze

        attribute :name, type: Type::String
        attribute :classification, type: Type::String
        attribute :account_type, type: Type::StringFromSet.new(values: TYPES.keys)
        attribute :account_sub_type, type: Type::String
        attribute :number, type: Type::String
        attribute :description, type: Type::String
        attribute :active, type: Type::Boolean

        references_one :currency, to: Currency
      end
    end
  end
end
