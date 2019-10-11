# frozen_string_literal: true
require_relative '../searcher'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Deposit
        class Searcher < QuickBooksOnline::Searcher
          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'deposit',
                  limit: limit,
                  offset: offset
                )
                .map do |c|
                  LedgerSync::Deposit.new(
                    ledger_id: c.fetch('Id'),
                    name: c.dig('Id')
                  )
                end
            end
          end
        end
      end
    end
  end
end
