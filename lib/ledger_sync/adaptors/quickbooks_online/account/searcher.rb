# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        class Searcher < QuickBooksOnline::Searcher
          def resources
            @resources ||= begin
              adaptor
                .query(
                  resource: 'account',
                  query: "Name LIKE '%#{query}%'",
                  limit: limit,
                  offset: offset
                )
                .map do |c|
                  LedgerSerializer.new(resource: LedgerSync::Account.new).deserialize(hash: c)
                end
            end
          end
        end
      end
    end
  end
end
