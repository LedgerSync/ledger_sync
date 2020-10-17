# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module InferClientMixin
        module ClassMethods
          def inferred_client_class
            @inferred_client_class ||= begin
              return if name.nil?

              parts = name.split('::')

              LedgerSync.const_get(
                parts[1..parts.index('Ledgers').to_i + 1].join('::')
              )::Client
            end
          end
        end

        def self.included(base)
          base.extend ClassMethods
        end
      end
    end
  end
end
