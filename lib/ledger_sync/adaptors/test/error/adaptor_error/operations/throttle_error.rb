# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Test
      class Error
        class AdaptorError
          module Operations
            class ThrottleError < Operation::Update
              class Contract < LedgerSync::Adaptors::Contract
                schema do
                end
              end

              private

              def operate
                failure(
                  LedgerSync::Error::AdaptorError::ThrottleError.new(adaptor: adaptor)
                )
              end
            end
          end
        end
      end
    end
  end
end
