# frozen_string_literal: true

require_relative 'reference_type'

module LedgerSync
  module Adaptors
    module NetSuite
      module LedgerSerializerType
        class SubsidiaryType < ReferenceType
          def convert_from_ledger(value:)
            return if value.nil?
            raise "Resource hash.  Given: #{value.class.name}" unless value.is_a?(Hash)

            Subsidiary.new(
              ledger_id: value.fetch('id', nil)
            )
          end
        end
      end
    end
  end
end
