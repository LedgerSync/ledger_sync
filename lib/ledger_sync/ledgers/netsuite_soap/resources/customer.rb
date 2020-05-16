# frozen_string_literal: true

require_relative 'subsidiary'

module LedgerSync
  module Ledgers
    module NetSuiteSOAP
      class Customer < NetSuiteSOAP::Resource
        attribute :email, type: LedgerSync::Type::String
        attribute :name, type: LedgerSync::Type::String
        attribute :phone_number, type: LedgerSync::Type::String

        references_one :subsidiary, to: Subsidiary

        def first_name
          return if name.nil?

          name.split(' ').first
        end

        def last_name
          return if name.nil?

          name.split(' ')[1..-1]
        end
      end
    end
  end
end
