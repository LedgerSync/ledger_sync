# frozen_string_literal: true

require_relative '../reference/serializer'

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class DepositLineDetail
        class Serializer < QuickBooksOnline::Serializer
          references_one 'AccountRef',
                         resource_attribute: :Account,
                         serializer: Reference::Serializer

          references_one 'ClassRef',
                         resource_attribute: :Class,
                         serializer: Reference::Serializer

          attribute 'Entity' do |args = {}|
            resource = args.fetch(:resource)

            if resource.Entity.present?
              {
                'name' => resource.Entity.name,
                'value' => resource.Entity.ledger_id,
                'type' => Client.ledger_resource_type_for(
                  resource_class: resource.Entity.class
                ).classify
              }
            end
          end
        end
      end
    end
  end
end
