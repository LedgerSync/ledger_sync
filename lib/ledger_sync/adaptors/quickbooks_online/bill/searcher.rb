# frozen_string_literal: true
require_relative '../searcher'

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Bill
        class Searcher < QuickBooksOnline::Searcher
          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'bill',
                  limit: limit,
                  offset: offset
                )
                .map do |c|
                  LedgerSync::Bill.new(
                    ledger_id: c.fetch('Id')
                  )
                end
            end
          end
        end
      end
    end
  end
end
