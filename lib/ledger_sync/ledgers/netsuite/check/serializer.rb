# frozen_string_literal: true

require_relative '../reference/serializer'
require_relative '../check_line_item/serializer'

module LedgerSync
  module Ledgers
    module NetSuite
      class Check
        class Serializer < NetSuite::Serializer
          attribute :memo
          attribute :trandate

          references_one :account,
                         serializer: Reference::Serializer, if: :account_present?

          references_one :department,
                         serializer: Reference::Serializer, if: :department_present?

          references_one :currency,
                         serializer: Reference::Serializer, if: :currency_present?

          references_one :entity,
                         serializer: Reference::Serializer

          references_many 'expense.items',
                          resource_attribute: :line_items,
                          serializer: CheckLineItem::Serializer

          def account_present?(args = {})
            resource = args.fetch(:resource)

            resource.account.present?
          end

          def department_present?(args = {})
            resource = args.fetch(:resource)

            resource.department.present?
          end

          def currency_present?(args = {})
            resource = args.fetch(:resource)

            resource.currency.present?
          end
        end
      end
    end
  end
end
