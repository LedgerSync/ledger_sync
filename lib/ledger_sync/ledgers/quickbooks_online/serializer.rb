# frozen_string_literal: true

# Gem.find_files('ledger_sync/ledgers/quickbooks_online/serializer_type/**/*.rb').each { |path| require path }

module LedgerSync
  module Ledgers
    module QuickBooksOnline
      class Serializer < LedgerSync::Serializer
        def serialize(args = {})
          deep_merge_unmapped_values = args.fetch(:deep_merge_unmapped_values, {})
          only_changes               = args.fetch(:only_changes, false)
          resource                   = args.fetch(:resource)

          ret = super(
            only_changes: only_changes,
            resource: resource
          )
          return ret unless deep_merge_unmapped_values.any?

          deep_merge_if_not_mapped(
            current_hash: ret,
            hash_to_search: deep_merge_unmapped_values
          )
        end

        def self.amount(hash_attribute, args = {})
          attribute(
            hash_attribute,
            {
              type: Serialization::Type::IntegerToAmountFloatType.new
            }.merge(args)
          )
        end

        def self.date(hash_attribute, args = {})
          attribute(
            hash_attribute,
            {
              type: LedgerSync::Serialization::Type::FormatDateType.new(format: '%Y-%m-%d')
            }.merge(args)
          )
        end

        def self.id
          attribute('Id', resource_attribute: :ledger_id)
        end

        private

        def deep_merge_if_not_mapped(current_hash:, hash_to_search:)
          hash_to_search.each do |key, value|
            current_hash[key] = if current_hash.key?(key)
                                  if value.is_a?(Hash) && current_hash[key].present?
                                    deep_merge_if_not_mapped(
                                      current_hash: current_hash[key],
                                      hash_to_search: value
                                    )
                                  else
                                    current_hash[key]
                                  end
                                else
                                  value
                                end
          end

          current_hash
        end
      end
    end
  end
end
