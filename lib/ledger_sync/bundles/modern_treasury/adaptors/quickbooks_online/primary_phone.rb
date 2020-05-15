# frozen_string_literal: true

module LedgerSync
  module Bundles
    module ModernTreasury
      module Adaptors
        module QuickBooksOnline
          class PrimaryPhone < ResourceAdaptor
            attribute :FreeFormNumber, resource_attribute: :phone_number
          end
        end
      end
    end
  end
end
