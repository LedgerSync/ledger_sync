# frozen_string_literal: true

require_relative '../resource'

module LedgerSync
  module Bundles
    module ModernTreasury
      class Customer < ModernTreasury::Resource
        attribute :email, type: Type::String
        attribute :first_name, type: Type::String
        attribute :last_name, type: Type::String
        attribute :phone_number, type: Type::String

        references_one :subsidiary, to: Subsidiary

        def name
          [first_name, last_name].compact.join(' ').strip
        end
      end
    end
  end
end
