# frozen_string_literal: true

require 'spec_helper'

support :adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Adaptor, type: :serializable do
  include AdaptorHelpers

  subject { test_adaptor.serialize }

  it do
    h = {
      root: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
      objects: {
        'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' => {
          id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
          object: 'LedgerSync::Adaptors::Test::Adaptor',
          fingeprint: 'd751713988987e9331980363e24189ce',
          data: {
            adaptor_configuration: {
              object: :reference,
              id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff'
            }
          }
        },
        'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' => {
          id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
          object: 'LedgerSync::AdaptorConfiguration',
          fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff',
          data: {
            aliases: [
              :test
            ],
            module: 'Test',
            root_key: :test,
            rate_limiting_wait_in_seconds: 47,
            test: true
          }
        }
      }
    }
    expect(subject).to eq(h)
  end
end
