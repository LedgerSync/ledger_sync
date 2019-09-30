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
      subject = described_class.Success(:val, operation: :op, response: :resp).serialize

      h = {
        root: 'LedgerSync::OperationResult::Success/80778a803b98fc30f93770bbabe8ec31',
        objects: {
          'LedgerSync::OperationResult::Success/80778a803b98fc30f93770bbabe8ec31' => {
            id: 'LedgerSync::OperationResult::Success/80778a803b98fc30f93770bbabe8ec31',
            object: 'LedgerSync::OperationResult::Success',
            fingeprint: '80778a803b98fc30f93770bbabe8ec31',
            data: {
              value: :val,
              operation: :op,
              response: :resp
            }
          }
        }
      }
      expect(subject).to eq(h)
    end

    it do
      subject = described_class.Failure(:err, operation: :op, response: :resp).serialize

      h = {
        root: 'LedgerSync::OperationResult::Failure/587c864765aaa7776c9a32bea77e8745',
        objects: {
          'LedgerSync::OperationResult::Failure/587c864765aaa7776c9a32bea77e8745' => {
            id: 'LedgerSync::OperationResult::Failure/587c864765aaa7776c9a32bea77e8745',
            object: 'LedgerSync::OperationResult::Failure',
            fingeprint: '587c864765aaa7776c9a32bea77e8745',
            data: {
              error: :err,
              operation: :op,
              response: :resp
            }
          }
        }
      }
      expect(subject).to eq(h)
    end
  end

  describe LedgerSync::SyncResult do
    it do
      subject = described_class.Success(:val, sync: :sy).serialize
      h = {
        root: 'LedgerSync::SyncResult::Success/61c139b545bef6ce1b4e5cc87324cfa7',
        objects: {
          'LedgerSync::SyncResult::Success/61c139b545bef6ce1b4e5cc87324cfa7' => {
            id: 'LedgerSync::SyncResult::Success/61c139b545bef6ce1b4e5cc87324cfa7',
            object: 'LedgerSync::SyncResult::Success',
            fingeprint: '61c139b545bef6ce1b4e5cc87324cfa7',
            data: {
              value: :val,
              sync: :sy
            }
          }
        }
      }
      expect(subject).to eq(h)
    end

    it do
      subject = described_class.Failure(:err, sync: :sy).serialize

      h = { root: 'LedgerSync::SyncResult::Failure/e0a1e960cc1e681b86b587a685c045f4',
            objects: {
              'LedgerSync::SyncResult::Failure/e0a1e960cc1e681b86b587a685c045f4' => {
                id: 'LedgerSync::SyncResult::Failure/e0a1e960cc1e681b86b587a685c045f4',
                object: 'LedgerSync::SyncResult::Failure',
                fingeprint: 'e0a1e960cc1e681b86b587a685c045f4',
                data: {
                  error: :err,
                  sync: :sy
                }
              }
            } }
      expect(subject).to eq(h)
    end
  end

  describe LedgerSync::SearchResult do
    it do
      allow_any_instance_of(LedgerSync::Customer).to receive(:ledger_id).and_return(:asdf)
      subject = described_class.Success(:val, searcher: test_searcher).serialize

      h = {
        objects: { 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' => { data: { aliases: [:test], module: 'Test', rate_limiting_wait_in_seconds: 47, root_key: :test, test: true }, fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff', id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff', object: 'LedgerSync::AdaptorConfiguration' }, 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' => { data: { adaptor_configuration: { id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff', object: :reference } }, fingeprint: 'd751713988987e9331980363e24189ce', id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce', object: 'LedgerSync::Adaptors::Test::Adaptor' }, 'LedgerSync::Adaptors::Test::Customer::Searcher/e33dcde3d3013c9ab92d821a8e2302d1' => { data: { adaptor: { id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce', object: :reference }, pagination: {}, query: '', resources: [{ id: 'LedgerSync::Customer/1b33bc9e3194050d076d128c1b3f9659', object: :reference }, { id: 'LedgerSync::Customer/76bc4034f6ea9a35feff5b0e24e9c3f3', object: :reference }] }, fingeprint: 'e33dcde3d3013c9ab92d821a8e2302d1', id: 'LedgerSync::Adaptors::Test::Customer::Searcher/e33dcde3d3013c9ab92d821a8e2302d1', object: 'LedgerSync::Adaptors::Test::Customer::Searcher' }, 'LedgerSync::Customer/1b33bc9e3194050d076d128c1b3f9659' => { data: { email: nil, external_id: :"", ledger_id: :asdf, name: 'Test customer 0', phone_number: nil, sync_token: nil }, fingeprint: '1b33bc9e3194050d076d128c1b3f9659', id: 'LedgerSync::Customer/1b33bc9e3194050d076d128c1b3f9659', object: 'LedgerSync::Customer' }, 'LedgerSync::Customer/76bc4034f6ea9a35feff5b0e24e9c3f3' => { data: { email: nil, external_id: :"", ledger_id: :asdf, name: 'Test customer 1', phone_number: nil, sync_token: nil }, fingeprint: '76bc4034f6ea9a35feff5b0e24e9c3f3', id: 'LedgerSync::Customer/76bc4034f6ea9a35feff5b0e24e9c3f3', object: 'LedgerSync::Customer' }, 'LedgerSync::SearchResult::Success/f3f9cc5c9f12cfc115bf3903ec4005fc' => { data: { resources: [{ id: 'LedgerSync::Customer/1b33bc9e3194050d076d128c1b3f9659', object: :reference }, { id: 'LedgerSync::Customer/76bc4034f6ea9a35feff5b0e24e9c3f3', object: :reference }], searcher: { id: 'LedgerSync::Adaptors::Test::Customer::Searcher/e33dcde3d3013c9ab92d821a8e2302d1', object: :reference }, value: :val }, fingeprint: 'f3f9cc5c9f12cfc115bf3903ec4005fc', id: 'LedgerSync::SearchResult::Success/f3f9cc5c9f12cfc115bf3903ec4005fc', object: 'LedgerSync::SearchResult::Success' } },
        root: 'LedgerSync::SearchResult::Success/f3f9cc5c9f12cfc115bf3903ec4005fc'
      }
      expect(subject).to eq(h)
    end

    it do
      allow_any_instance_of(LedgerSync::Customer).to receive(:ledger_id).and_return(:asdf)
      subject = described_class.Failure(:val, searcher: test_searcher).serialize

      h = {
        objects: { 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff' => { data: { aliases: [:test], module: 'Test', rate_limiting_wait_in_seconds: 47, root_key: :test, test: true }, fingeprint: '7ff9ef0b13e681003c8015f59d0b5eff', id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff', object: 'LedgerSync::AdaptorConfiguration' }, 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce' => { data: { adaptor_configuration: { id: 'LedgerSync::AdaptorConfiguration/7ff9ef0b13e681003c8015f59d0b5eff', object: :reference } }, fingeprint: 'd751713988987e9331980363e24189ce', id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce', object: 'LedgerSync::Adaptors::Test::Adaptor' }, 'LedgerSync::Adaptors::Test::Customer::Searcher/e33dcde3d3013c9ab92d821a8e2302d1' => { data: { adaptor: { id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce', object: :reference }, pagination: {}, query: '', resources: [{ id: 'LedgerSync::Customer/1b33bc9e3194050d076d128c1b3f9659', object: :reference }, { id: 'LedgerSync::Customer/76bc4034f6ea9a35feff5b0e24e9c3f3', object: :reference }] }, fingeprint: 'e33dcde3d3013c9ab92d821a8e2302d1', id: 'LedgerSync::Adaptors::Test::Customer::Searcher/e33dcde3d3013c9ab92d821a8e2302d1', object: 'LedgerSync::Adaptors::Test::Customer::Searcher' }, 'LedgerSync::Customer/1b33bc9e3194050d076d128c1b3f9659' => { data: { email: nil, external_id: :"", ledger_id: :asdf, name: 'Test customer 0', phone_number: nil, sync_token: nil }, fingeprint: '1b33bc9e3194050d076d128c1b3f9659', id: 'LedgerSync::Customer/1b33bc9e3194050d076d128c1b3f9659', object: 'LedgerSync::Customer' }, 'LedgerSync::Customer/76bc4034f6ea9a35feff5b0e24e9c3f3' => { data: { email: nil, external_id: :"", ledger_id: :asdf, name: 'Test customer 1', phone_number: nil, sync_token: nil }, fingeprint: '76bc4034f6ea9a35feff5b0e24e9c3f3', id: 'LedgerSync::Customer/76bc4034f6ea9a35feff5b0e24e9c3f3', object: 'LedgerSync::Customer' }, 'LedgerSync::SearchResult::Failure/a8f6f725c41d453d2f6826d51b9734a2' => { data: { error: :val, resources: [{ id: 'LedgerSync::Customer/1b33bc9e3194050d076d128c1b3f9659', object: :reference }, { id: 'LedgerSync::Customer/76bc4034f6ea9a35feff5b0e24e9c3f3', object: :reference }], searcher: { id: 'LedgerSync::Adaptors::Test::Customer::Searcher/e33dcde3d3013c9ab92d821a8e2302d1', object: :reference } }, fingeprint: 'a8f6f725c41d453d2f6826d51b9734a2', id: 'LedgerSync::SearchResult::Failure/a8f6f725c41d453d2f6826d51b9734a2', object: 'LedgerSync::SearchResult::Failure' } },
        root: 'LedgerSync::SearchResult::Failure/a8f6f725c41d453d2f6826d51b9734a2'
      }
      expect(subject).to eq(h)
    end
  end
end
