# frozen_string_literal: true

module LedgerSync
  module Bundles
    module ModernTreasury
      class Subsidiary < ModernTreasury::Resource
    attribute :name, type: Type::String
    attribute :state, type: Type::String
      end
    end
  end
end
