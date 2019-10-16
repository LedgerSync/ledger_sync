# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module LedgerSerializerType
      class Mapping < Value
        attr_reader :source, :value

        def self.mapping
          @mapping ||= begin
            raise NotImplementedError
          end
        end

        def convert_from_ledger(value:)
          return if value.nil?
          raise "Ledger to local mapping not found: #{value}" unless reverse_mapping_hash.key?(value)

          reverse_mapping_hash[value]
        end

        def convert_from_local(value:)
          return if value.nil?
          raise "Local to ledger mapping not found: #{value}" unless mapping_hash.key?(value)

          mapping_hash[value]
        end

        private

        def mapping_hash
          @mapping_hash ||= self.class.mapping
        end

        def reverse_mapping_hash
          @reverse_mapping_hash ||= mapping_hash.to_a.map(&:reverse).to_h
        end
      end
    end
  end
end
