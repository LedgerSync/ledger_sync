# frozen_string_literal: true

require 'spec_helper'
RSpec.describe LedgerSync::Result, type: :serializable do
  describe LedgerSync::Result do
    it do
      subject = described_class.Success(:val).simply_serialize
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
      subject = described_class.Failure(:err).simply_serialize
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
      subject = described_class.Success(:val, operation: :op, resource: :res, response: :resp).simply_serialize

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
      subject = described_class.Failure(:err, operation: :op, resource: :res, response: :resp).simply_serialize

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
end
