
# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Txn
        class LedgerSerializer < QuickBooksOnline::LedgerSerializer
          attribute ledger_attribute: 'TxnId',
                    resource_attribute: 'entity.ledger_id'


          attribute ledger_attribute: 'TxnType' do |resource|
            entity_class = resource.entity.class.to_s.split('::').last
            entity_serializer = "LedgerSync::Adaptors::QuickBooksOnline::#{entity_class}::LedgerSerializer".constantize

            entity_serializer.quickbooks_online_resource_type.capitalize
          end
        end
      end
    end
  end
end
