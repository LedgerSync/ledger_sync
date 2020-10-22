# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Mixins
      module InferClientMixin
        module ClassMethods
          def inferred_client_class
            @inferred_client_class ||= begin
              return if name.nil?

              ledger = LedgerSync.ledgers.find do |ledger_config|
                (ledger_config.base_module.to_s.split('::') - name.to_s.split('::')).empty?
              end

              ledger&.client_class
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
