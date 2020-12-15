# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Operation do
  let(:resource) { LedgerSync::Ledgers::TestLedger::Customer.new }
  let(:client) do
    LedgerSync::Ledgers::TestLedger::Client.new(
      api_key: :api_key
    )
  end

  describe '.create' do
    it do
      args = {
        method: :create,
        resource: resource
      }
      expect(client).to receive(:operation_for).once.with(args)
      described_class.create(args.merge(client: client))
    end
  end

  describe '.delete' do
    it do
      args = {
        method: :delete,
        resource: resource
      }
      expect(client).to receive(:operation_for).once.with(args)
      described_class.delete(args.merge(client: client))
    end
  end

  describe '.find' do
    it do
      args = {
        method: :find,
        resource: resource
      }
      expect(client).to receive(:operation_for).once.with(args)
      described_class.find(args.merge(client: client))
    end
  end

  describe '.update' do
    it do
      args = {
        method: :update,
        resource: resource
      }
      expect(client).to receive(:operation_for).once.with(args)
      described_class.update(args.merge(client: client))
    end
  end
end
