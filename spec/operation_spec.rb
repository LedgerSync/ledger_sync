# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Operation do
  let(:resource) { LedgerSync::Bundles::ModernTreasury::Customer.new }
  let(:adaptor) do
    LedgerSync::Adaptors::NetSuite::Adaptor.new(
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
      expect(adaptor).to receive(:operation_for).once.with(args)
      described_class.create(args.merge(adaptor: adaptor))
    end
  end

  describe '.delete' do
    it do
      args = {
        method: :delete,
        resource: resource
      }
      expect(adaptor).to receive(:operation_for).once.with(args)
      described_class.delete(args.merge(adaptor: adaptor))
    end
  end

  describe '.find' do
    it do
      args = {
        method: :find,
        resource: resource
      }
      expect(adaptor).to receive(:operation_for).once.with(args)
      described_class.find(args.merge(adaptor: adaptor))
    end
  end

  describe '.update' do
    it do
      args = {
        method: :update,
        resource: resource
      }
      expect(adaptor).to receive(:operation_for).once.with(args)
      described_class.update(args.merge(adaptor: adaptor))
    end
  end
end
