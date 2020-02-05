module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Preference
        module Operations
          class Find < Operation::Find
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:external_id).maybe(:string)
                required(:ledger_id).value(:nil)
              end
            end
          end
        end
      end
    end
  end
end
