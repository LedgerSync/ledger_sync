# frozen_string_literal: true

module LedgerSync
  module Bundles
    module ModernTreasury
      module Adaptors
        module QuickBooksOnline
          class PrimaryEmailAddr < ResourceAdaptor
            attribute :Address, resource_attribute: :email
          end
        end
      end
    end
  end
end
