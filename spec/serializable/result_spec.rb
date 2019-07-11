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
        root: 'LedgerSync::SearchResult::Success/9dc30f9c62b7043925233868490041f4',
        objects: {
          'LedgerSync::SearchResult::Success/9dc30f9c62b7043925233868490041f4' => {
            id: 'LedgerSync::SearchResult::Success/9dc30f9c62b7043925233868490041f4',
            object: 'LedgerSync::SearchResult::Success',
            fingeprint: '9dc30f9c62b7043925233868490041f4',
            data: {
              value: :val,
              resources: [
                {
                  object: :reference,
                  id: 'LedgerSync::Customer/d3e1740701c816fdf9078a1d9a342290'
                },
                {
                  object: :reference,
                  id: 'LedgerSync::Customer/cc8859091004fde94486a698374fc300'
                }
              ],
              searcher: {
                object: :reference,
                id: 'LedgerSync::Adaptors::Test::Customer::Searcher/c468c89b7747822a7828882e8b7e87f5'
              }
            }
          },
          'LedgerSync::Customer/d3e1740701c816fdf9078a1d9a342290' => {
            id: 'LedgerSync::Customer/d3e1740701c816fdf9078a1d9a342290',
            object: 'LedgerSync::Customer',
            fingeprint: 'd3e1740701c816fdf9078a1d9a342290',
            data: {
              phone_number: nil,
              name: 'Test customer 0',
              ledger_id: :asdf,
              email: nil,
              external_id: :"",
              sync_token: nil
            }
          },
          'LedgerSync::Customer/cc8859091004fde94486a698374fc300' => {
            id: 'LedgerSync::Customer/cc8859091004fde94486a698374fc300',
            object: 'LedgerSync::Customer',
            fingeprint: 'cc8859091004fde94486a698374fc300',
            data: {
              phone_number: nil,
              name: 'Test customer 1',
              ledger_id: :asdf,
              email: nil,
              external_id: :"",
              sync_token: nil
            }
          },
          'LedgerSync::Adaptors::Test::Customer::Searcher/c468c89b7747822a7828882e8b7e87f5' => {
            id: 'LedgerSync::Adaptors::Test::Customer::Searcher/c468c89b7747822a7828882e8b7e87f5',
            object: 'LedgerSync::Adaptors::Test::Customer::Searcher',
            fingeprint: 'c468c89b7747822a7828882e8b7e87f5',
            data: {
              adaptor: {
                object: :reference,
                id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce'
              },
              query: '',
              pagination: {},
              resources: [
                {
                  object: :reference,
                  id: 'LedgerSync::Customer/d3e1740701c816fdf9078a1d9a342290'
                },
                {
                  object: :reference,
                  id: 'LedgerSync::Customer/cc8859091004fde94486a698374fc300'
                }
              ]
            }
          },
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

    it do
      allow_any_instance_of(LedgerSync::Customer).to receive(:ledger_id).and_return(:asdf)
      subject = described_class.Failure(:val, searcher: test_searcher).serialize

      h = {
        root: 'LedgerSync::SearchResult::Failure/30f1fc95b5cab72b2e547e4fa2ff5fde',
        objects: {
          'LedgerSync::SearchResult::Failure/30f1fc95b5cab72b2e547e4fa2ff5fde' => {
            id: 'LedgerSync::SearchResult::Failure/30f1fc95b5cab72b2e547e4fa2ff5fde',
            object: 'LedgerSync::SearchResult::Failure',
            fingeprint: '30f1fc95b5cab72b2e547e4fa2ff5fde',
            data: {
              error: :val,
              resources: [
                {
                  object: :reference,
                  id: 'LedgerSync::Customer/d3e1740701c816fdf9078a1d9a342290'
                },
                {
                  object: :reference,
                  id: 'LedgerSync::Customer/cc8859091004fde94486a698374fc300'
                }
              ],
              searcher: {
                object: :reference,
                id: 'LedgerSync::Adaptors::Test::Customer::Searcher/c468c89b7747822a7828882e8b7e87f5'
              }
            }
          },
          'LedgerSync::Customer/d3e1740701c816fdf9078a1d9a342290' => {
            id: 'LedgerSync::Customer/d3e1740701c816fdf9078a1d9a342290',
            object: 'LedgerSync::Customer',
            fingeprint: 'd3e1740701c816fdf9078a1d9a342290',
            data: {
              phone_number: nil,
              name: 'Test customer 0',
              ledger_id: :asdf,
              email: nil,
              external_id: :"",
              sync_token: nil
            }
          },
          'LedgerSync::Customer/cc8859091004fde94486a698374fc300' => {
            id: 'LedgerSync::Customer/cc8859091004fde94486a698374fc300',
            object: 'LedgerSync::Customer',
            fingeprint: 'cc8859091004fde94486a698374fc300',
            data: {
              phone_number: nil,
              name: 'Test customer 1',
              ledger_id: :asdf,
              email: nil,
              external_id: :"",
              sync_token: nil
            }
          },
          'LedgerSync::Adaptors::Test::Customer::Searcher/c468c89b7747822a7828882e8b7e87f5' => {
            id: 'LedgerSync::Adaptors::Test::Customer::Searcher/c468c89b7747822a7828882e8b7e87f5',
            object: 'LedgerSync::Adaptors::Test::Customer::Searcher',
            fingeprint: 'c468c89b7747822a7828882e8b7e87f5',
            data: {
              adaptor: {
                object: :reference,
                id: 'LedgerSync::Adaptors::Test::Adaptor/d751713988987e9331980363e24189ce'
              },
              query: '',
              pagination: {},
              resources: [
                {
                  object: :reference,
                  id: 'LedgerSync::Customer/d3e1740701c816fdf9078a1d9a342290'
                },
                {
                  object: :reference,
                  id: 'LedgerSync::Customer/cc8859091004fde94486a698374fc300'
                }
              ]
            }
          },
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
end
