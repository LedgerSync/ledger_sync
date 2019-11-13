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
        'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' =>
        {
          id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
          object: 'LedgerSync::Adaptors::Test::Adaptor',
          fingeprint: 'd751713988987e9331980363e24189ce',
          data: {
            adaptor_configuration: {
              object: :reference,
              id: 'LedgerSync::AdaptorConfiguration/0997cbf8db8b154bcaa6668078de52d1'
            }
          }
        },
        'LedgerSync::AdaptorConfiguration/0997cbf8db8b154bcaa6668078de52d1' =>
         {
           id: 'LedgerSync::AdaptorConfiguration/0997cbf8db8b154bcaa6668078de52d1',
           object: 'LedgerSync::AdaptorConfiguration',
           fingeprint: '0997cbf8db8b154bcaa6668078de52d1',
           data: {
             aliases: [:test],
             module_string: 'Test',
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
