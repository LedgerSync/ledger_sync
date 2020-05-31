# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Department
        class Deserializer < QuickBooksOnline::Deserializer
          id

          attribute :name,
                    hash_attribute: 'Name'
          attribute :active,
                    hash_attribute: 'Active'
          attribute :sub_department,
                    hash_attribute: 'SubDepartment'
          attribute :fully_qualified_name,
                    hash_attribute: 'FullyQualifiedName'

          attribute(:parent) do |args = {}|
            hash = args.fetch(:hash)

            LedgerSync::QuickBooks::Department.new(ledger_id: hash['ParentRef']) if hash['ParentRef'].nil?
          end
        end
      end
    end
  end
end
