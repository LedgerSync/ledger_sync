# frozen_string_literal: true

# require client-specific types
Gem.find_files('ledger_sync/ledgers/netsuite/type/**/*.rb').each { |path| require path }

module LedgerSync
  module Ledgers
    module NetSuite
      class Serializer < LedgerSync::Serializer
        def self.id
          attribute :id, resource_attribute: :ledger_id
        end

        def self.ledger_reference(hash_attribute, args = {})
          attribute hash_attribute,
                    args.merge(type: Type::SerializerReferenceType.new)
        end
      end
    end
  end
end
