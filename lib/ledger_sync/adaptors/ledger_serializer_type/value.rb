# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module LedgerSerializerType
      class Value
        attr_reader :attribute,
                    :resource,
                    :serializer,
                    :source,
                    :value

        def initialize(attribute:, resource:, serializer:, source:, value:)
          raise 'Invalid source.  Must be ledger or local' unless %i[ledger local].include?(source)

          @attribute = attribute
          @resource = resource
          @serializer = serializer
          @source = source
          @value = value
        end

        def ledger_source?
          source == :ledger
        end

        def local_source?
          source == :local
        end

        def convert(*)
          return convert_from_ledger if ledger_source?

          convert_from_local
        end

        private

        def convert_from_ledger
          value
        end

        def convert_from_local
          value
        end
      end
    end
  end
end
