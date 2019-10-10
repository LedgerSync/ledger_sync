# frozen_string_literal: true

require 'spec_helper'
support 'adaptor_helpers'

RSpec.describe LedgerSync::Result, type: :serializable do
  include AdaptorHelpers

  describe LedgerSync::Result do
    it do
      subject = described_class.Success(:val).serialize
      h = {
        root: 'LedgerSync::Result::Success/4672086a9a6a647b29b781ff64b41242',
        objects: {
          'LedgerSync::Result::Success/4672086a9a6a647b29b781ff64b41242' => {
            id: 'LedgerSync::Result::Success/4672086a9a6a647b29b781ff64b41242',
            object: 'LedgerSync::Result::Success',
            fingeprint: '4672086a9a6a647b29b781ff64b41242',
            data: {
              value: :val
            }
          }
        }
      }
      expect(subject).to eq(h)
    end

    it do
      subject = described_class.Failure(:err).serialize
      h = {
        root: 'LedgerSync::Result::Failure/a6494d65e10ac3a996299313a0be9ac1',
        objects: {
          'LedgerSync::Result::Failure/a6494d65e10ac3a996299313a0be9ac1' => {
            id: 'LedgerSync::Result::Failure/a6494d65e10ac3a996299313a0be9ac1',
            object: 'LedgerSync::Result::Failure',
            fingeprint: 'a6494d65e10ac3a996299313a0be9ac1',
            data: {
              error: :err
            }
          }
        }
      }
      expect(subject).to eq(h)
    end
  end

  describe LedgerSync::OperationResult do
    it do
      subject = described_class.Success(:val, operation: :op, resource: :res, response: :resp).serialize

      h = {
        root: 'LedgerSync::OperationResult::Success/1863f02d2c39343180f0068db0ffdd96',
        objects: {
          'LedgerSync::OperationResult::Success/1863f02d2c39343180f0068db0ffdd96' => {
            data: {
              operation: :op,
              resource: :res,
              response: :resp,
              value: :val
            },
            fingeprint: '1863f02d2c39343180f0068db0ffdd96',
            id: 'LedgerSync::OperationResult::Success/1863f02d2c39343180f0068db0ffdd96',
            object: 'LedgerSync::OperationResult::Success'
          }
        }
      }
      expect(subject).to eq(h)
    end

    it do
      subject = described_class.Failure(:err, operation: :op, resource: :res, response: :resp).serialize

      h = {
        root: 'LedgerSync::OperationResult::Failure/4e173f03055f33005bb3c71a3ffafe6c',
        objects: {
          'LedgerSync::OperationResult::Failure/4e173f03055f33005bb3c71a3ffafe6c' => {
            data: {
              error: :err,
              operation: :op,
              resource: :res,
              response: :resp
            },
            fingeprint: '4e173f03055f33005bb3c71a3ffafe6c',
            id: 'LedgerSync::OperationResult::Failure/4e173f03055f33005bb3c71a3ffafe6c',
            object: 'LedgerSync::OperationResult::Failure'
          }
        }
      }
      expect(subject).to eq(h)
    end
  end

  describe LedgerSync::SearchResult do
    xit do
      allow_any_instance_of(LedgerSync::Customer).to receive(:ledger_id).and_return(:asdf)
      subject = described_class.Success(:val, searcher: test_searcher).serialize

      h = {
        objects: {
          'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' => {
            data: {
              aliases: [:test],
              module: 'Test',
              rate_limiting_wait_in_seconds: 47,
              root_key: :test,
              test: true
            },
            fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff',
            id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
            object: 'LedgerSync::AdaptorConfiguration'
          },
          'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' => {
            data: {
              adaptor_configuration: {
                id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
                object: :reference
              }
            },
            fingeprint: 'd751713988987e9331980363e24189ce',
            id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
            object: 'LedgerSync::Adaptors::Test::Adaptor'
          },
          'LedgerSync::Adaptors::Test::Customer::Searcher/9c7beeb5ce5fc76aaccc73ded30d4010' => {
            data: {
              adaptor: {
                id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
                object: :reference
              },
              pagination: {

              },
              query: '',
              resources: [{
                id: 'LedgerSync::Customer/0bce46b00949dc9db1d717d38ea9356c',
                object: :reference
              },
                          {
                            id: 'LedgerSync::Customer/8fd0a86b38a3a4e127389d97a3782606',
                            object: :reference
                          }]
            },
            fingeprint: '9c7beeb5ce5fc76aaccc73ded30d4010',
            id: 'LedgerSync::Adaptors::Test::Customer::Searcher/9c7beeb5ce5fc76aaccc73ded30d4010',
            object: 'LedgerSync::Adaptors::Test::Customer::Searcher'
          },
          'LedgerSync::Customer/0bce46b00949dc9db1d717d38ea9356c' => {
            data: {
              email: nil,
              external_id: nil,
              ledger_id: :asdf,
              name: 'Test customer 0',
              phone_number: nil,
              sync_token: nil
            },
            fingeprint: '0bce46b00949dc9db1d717d38ea9356c',
            id: 'LedgerSync::Customer/0bce46b00949dc9db1d717d38ea9356c',
            object: 'LedgerSync::Customer'
          },
          'LedgerSync::Customer/8fd0a86b38a3a4e127389d97a3782606' => {
            data: {
              email: nil,
              external_id: nil,
              ledger_id: :asdf,
              name: 'Test customer 1',
              phone_number: nil,
              sync_token: nil
            },
            fingeprint: '8fd0a86b38a3a4e127389d97a3782606',
            id: 'LedgerSync::Customer/8fd0a86b38a3a4e127389d97a3782606',
            object: 'LedgerSync::Customer'
          },
          'LedgerSync::SearchResult::Success/c9a5b9b6804f2be89eb7df07b67f0222' => {
            data: {
              resources: [{
                id: 'LedgerSync::Customer/0bce46b00949dc9db1d717d38ea9356c',
                object: :reference
              },
                          {
                            id: 'LedgerSync::Customer/8fd0a86b38a3a4e127389d97a3782606',
                            object: :reference
                          }],
              searcher: {
                id: 'LedgerSync::Adaptors::Test::Customer::Searcher/9c7beeb5ce5fc76aaccc73ded30d4010',
                object: :reference
              },
              value: :val
            },
            fingeprint: 'c9a5b9b6804f2be89eb7df07b67f0222',
            id: 'LedgerSync::SearchResult::Success/c9a5b9b6804f2be89eb7df07b67f0222',
            object: 'LedgerSync::SearchResult::Success'
          }
        },
        root: 'LedgerSync::SearchResult::Success/c9a5b9b6804f2be89eb7df07b67f0222'
      }
      expect(subject).to eq(h)
    end

    xit do
      allow_any_instance_of(LedgerSync::Customer).to receive(:ledger_id).and_return(:asdf)
      subject = described_class.Failure(:val, searcher: test_searcher).serialize

      h = {
        objects: {
          'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' => {
            data: {
              aliases: [:test],
              module: 'Test',
              rate_limiting_wait_in_seconds: 47,
              root_key: :test,
              test: true
            },
            fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff',
            id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
            object: 'LedgerSync::AdaptorConfiguration'
          },
          'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' => {
            data: {
              adaptor_configuration: {
                id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff',
                object: :reference
              }
            },
            fingeprint: 'd751713988987e9331980363e24189ce',
            id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
            object: 'LedgerSync::Adaptors::Test::Adaptor'
          },
          'LedgerSync::Adaptors::Test::Customer::Searcher/9c7beeb5ce5fc76aaccc73ded30d4010' => {
            data: {
              adaptor: {
                id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce',
                object: :reference
              },
              pagination: {

              },
              query: '',
              resources: [{
                id: 'LedgerSync::Customer/0bce46b00949dc9db1d717d38ea9356c',
                object: :reference
              },
                          {
                            id: 'LedgerSync::Customer/8fd0a86b38a3a4e127389d97a3782606',
                            object: :reference
                          }]
            },
            fingeprint: '9c7beeb5ce5fc76aaccc73ded30d4010',
            id: 'LedgerSync::Adaptors::Test::Customer::Searcher/9c7beeb5ce5fc76aaccc73ded30d4010',
            object: 'LedgerSync::Adaptors::Test::Customer::Searcher'
          },
          'LedgerSync::Customer/0bce46b00949dc9db1d717d38ea9356c' => {
            data: {
              email: nil,
              external_id: nil,
              ledger_id: :asdf,
              name: 'Test customer 0',
              phone_number: nil,
              sync_token: nil
            },
            fingeprint: '0bce46b00949dc9db1d717d38ea9356c',
            id: 'LedgerSync::Customer/0bce46b00949dc9db1d717d38ea9356c',
            object: 'LedgerSync::Customer'
          },
          'LedgerSync::Customer/8fd0a86b38a3a4e127389d97a3782606' => {
            data: {
              email: nil,
              external_id: nil,
              ledger_id: :asdf,
              name: 'Test customer 1',
              phone_number: nil,
              sync_token: nil
            },
            fingeprint: '8fd0a86b38a3a4e127389d97a3782606',
            id: 'LedgerSync::Customer/8fd0a86b38a3a4e127389d97a3782606',
            object: 'LedgerSync::Customer'
          },
          'LedgerSync::SearchResult::Failure/e7006403c6ec98c1bf0261f0d8622949' => {
            data: {
              error: :val,
              resources: [{
                id: 'LedgerSync::Customer/0bce46b00949dc9db1d717d38ea9356c',
                object: :reference
              },
                          {
                            id: 'LedgerSync::Customer/8fd0a86b38a3a4e127389d97a3782606',
                            object: :reference
                          }],
              searcher: {
                id: 'LedgerSync::Adaptors::Test::Customer::Searcher/9c7beeb5ce5fc76aaccc73ded30d4010',
                object: :reference
              }
            },
            fingeprint: 'e7006403c6ec98c1bf0261f0d8622949',
            id: 'LedgerSync::SearchResult::Failure/e7006403c6ec98c1bf0261f0d8622949',
            object: 'LedgerSync::SearchResult::Failure'
          }
        },
        root: 'LedgerSync::SearchResult::Failure/e7006403c6ec98c1bf0261f0d8622949'
      }
      expect(subject).to eq(h)
    end
  end
end
