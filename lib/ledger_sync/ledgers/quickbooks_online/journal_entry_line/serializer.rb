# frozen_string_literal: true

require_relative '../journal_entry_line_detail/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class JournalEntryLine
        class Serializer < QuickBooksOnline::Serializer
          amount :Amount
          attribute :Description

          attribute 'DetailType' do
            'JournalEntryLineDetail'
          end

          references_one :JournalEntryLineDetail,
                         resource_attribute: :JournalEntryLineDetail,
                         serializer: JournalEntryLineDetail::Serializer
        end
      end
    end
  end
end
