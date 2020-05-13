# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Operation do
  let(:resource) { LedgerSync::Bundles::ModernTreasury::Customer.new }
  let(:client) do
    LedgerSync::Ledgers::NetSuite::Client.new(
      account_id: :account_id,
      consumer_key: :consumer_key,
      consumer_secret: :consumer_secret,
      token_id: :token_id,
      token_secret: :token_secret
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
