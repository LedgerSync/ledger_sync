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

        private

        def convert_from_ledger
          raise "Ledger to local mapping not found: #{value}" unless reverse_hash.key?(value)

          reverse_hash[value]
        end

        def convert_from_local
          raise "Local to ledger mapping not found: #{value}" unless hash.key?(value)

          hash[value]
        end

        def hash
          @hash ||= self.class.mapping
        end

        def reverse_hash
          @reverse_hash ||= hash.to_a.map(&:reverse).to_h
        end
      end
    end
  end
end
